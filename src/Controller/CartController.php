<?php

namespace App\Controller;

use App\Entity\Product;
use App\Service\CartService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/cart')]
class CartController extends AbstractController
{
    public function __construct(private readonly CartService $cartService)
    {
    }

    #[Route('', name: 'app_cart_index', methods: ['GET'])]
    public function index(): Response
    {
        return $this->render('cart/index.html.twig', [
            'cart' => $this->cartService->getCart(),
        ]);
    }

    #[Route('/add/{id}', name: 'app_cart_add', methods: ['POST'])]
    public function add(Product $product, Request $request): Response
    {
        $quantity = $request->request->getInt('quantity', 1);

        if ($quantity > $product->getStock()) {
            $this->addFlash('danger', 'Not enough stock available.');
            return $this->redirectToRoute('app_product_show', ['id' => $product->getId()]);
        }

        $this->cartService->addItem($product, $quantity);
        $this->addFlash('success', 'Product added to cart successfully.');

        return $this->redirectToRoute('app_cart_index');
    }

    #[Route('/update/{id}', name: 'app_cart_update', methods: ['POST'])]
    public function update(Product $product, Request $request): Response
    {
        $action = $request->request->get('action');

        if ($action === 'increase') {
            $this->cartService->increaseQuantity($product);
        } elseif ($action === 'decrease') {
            $this->cartService->decreaseQuantity($product);
        }

        return $this->redirectToRoute('app_cart_index');
    }

    #[Route('/remove/{id}', name: 'app_cart_remove', methods: ['POST'])]
    public function remove(Product $product): Response
    {
        $this->cartService->removeItem($product);
        $this->addFlash('success', 'Product removed from cart successfully.');

        return $this->redirectToRoute('app_cart_index');
    }

    #[Route('/clear', name: 'app_cart_clear', methods: ['POST'])]
    public function clear(): Response
    {
        $this->cartService->clear();
        $this->addFlash('success', 'Cart cleared successfully.');

        return $this->redirectToRoute('app_cart_index');
    }

    #[Route('/apply-promo', name: 'app_cart_apply_promo', methods: ['POST'])]
    public function applyPromoCode(Request $request): Response
    {
        $code = $request->request->get('code');

        if ($this->cartService->applyPromoCode($code)) {
            $this->addFlash('success', 'Promo code applied successfully.');
        } else {
            $this->addFlash('danger', 'Invalid promo code.');
        }

        return $this->redirectToRoute('app_cart_index');
    }
}