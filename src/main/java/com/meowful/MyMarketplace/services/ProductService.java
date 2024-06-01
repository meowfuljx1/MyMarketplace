package com.meowful.MyMarketplace.services;

import com.meowful.MyMarketplace.models.Product;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.repositories.ProductRepository;
import com.meowful.MyMarketplace.repositories.UserRepository;
import jakarta.activation.MimetypesFileTypeMap;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserService userService;

    public List<Product> getProducts(String title) {
        if (title == null || title.isEmpty()) return productRepository.findAll();
        else return productRepository.findByTitle(title);
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).get();
    }

    public void deleteProduct(Long id) {
        Product product = productRepository.findById(id).get();
        productRepository.delete(product);
    }

    public void updateProduct(Product newProduct, List<MultipartFile> files, Long productId) {
        Product product = productRepository.findById(productId).get();

        product.setTitle(newProduct.getTitle());
        product.setDescription(newProduct.getDescription());
        product.setPrice(newProduct.getPrice());
        product.setCity(newProduct.getCity());

        String typeOfOperation = "update";
        addImagesToProduct(product, files, typeOfOperation);
        productRepository.save(product);
    }

    public boolean addProduct(Product product, Principal principal, List<MultipartFile> files) {
        boolean imagesAdded = addImagesToProduct(product, files, "create");
        if (imagesAdded) {
            product.setUser(userService.getUser(principal));
            productRepository.save(product);
            return true;
        }
        else return false;
    }

    public boolean addImagesToProduct(Product product, List<MultipartFile> files, String typeOfOperation) {
        List<MultipartFile> validFiles = fileValidation(files);

        switch (typeOfOperation){

            case "create":
            {
                if (!validFiles.isEmpty()){
                    List<String> stringImages = getListOfStringImages(validFiles);
                    product.setPreviewImg(stringImages.get(0));
                    product.setImages(stringImages);
                    return true;
                }
                else return false;
            }

            // update
            default:
            {
                if (!validFiles.isEmpty()){
                    List<String> stringImages = getListOfStringImages(validFiles);
                    product.getImages().clear();
                    product.setPreviewImg(stringImages.get(0));
                    product.setImages(stringImages);
                }
                return true;
            }
        }

    }

    public List<MultipartFile> fileValidation(List<MultipartFile> files) {
        List<MultipartFile> validFiles = new ArrayList<>();

        for (MultipartFile file : files) {
            if (
                    file.getSize() != 0 &&
                            !StringUtils.cleanPath(file.getOriginalFilename()).contains("..") &&
                            (new MimetypesFileTypeMap().getContentType(file.getOriginalFilename()).startsWith("image/"))
            )
                validFiles.add(file);
        }
        return validFiles;
    }

    public List<String> getListOfStringImages(List<MultipartFile> files) {
        List<String> stringImages = new ArrayList<>();

        for (MultipartFile file : files) {
            try {
                stringImages.add(Base64.getEncoder().encodeToString(file.getBytes()));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return stringImages;
    }


}
