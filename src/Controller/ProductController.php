<?php

namespace App\Controller;

use App\Entity\Product;
use App\Repository\CategoryRepository;
use App\Repository\ProductRepository;
use App\Service\CartService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/product')]
class ProductController extends AbstractController
{
    #[Route('/', name: 'app_product_index', methods: ['GET'])]
    public function index(ProductRepository $productRepository, CategoryRepository $categoryRepository): Response
    {
        return $this->render('product/index.html.twig', [
            'products' => $productRepository->findAll(),
            'categories' => $categoryRepository->findAll(),
        ]);
    }

    #[Route('/{id}', name: 'app_product_show', methods: ['GET'])]
    public function show(Product $product): Response
    {
        return $this->render('product/show.html.twig', [
            'product' => $product,
        ]);
    }

    #[Route('/search', name: 'app_product_search', methods: ['GET'])]
    public function search(Request $request, ProductRepository $productRepository): Response
    {
        $query = $request->query->get('q');
        $products = $query ? $productRepository->findBySearch($query) : [];

        return $this->render('product/search.html.twig', [
            'products' => $products,
            'query' => $query,
        ]);
    }

    #[Route('/category/{id}', name: 'app_product_category', methods: ['GET'])]
    public function category(int $id, ProductRepository $productRepository, CategoryRepository $categoryRepository): Response
    {
        $category = $categoryRepository->find($id);
        if (!$category) {
            throw $this->createNotFoundException('Category not found');
        }

        return $this->render('product/category.html.twig', [
            'category' => $category,
            'categories' => $categoryRepository->findAll(),
            'products' => $productRepository->findByCategory($id),
        ]);
    }

    #[Route('/{id}/add-to-cart', name: 'app_product_add_to_cart', methods: ['POST'])]
    public function addToCart(Product $product, Request $request, CartService $cartService): Response
    {
        $quantity = (int) $request->request->get('quantity', 1);
        $cartService->add($product->getId(), $quantity);

        $this->addFlash('success', 'Product added to cart');

        return $this->redirectToRoute('app_product_show', ['id' => $product->getId()]);
    }
}