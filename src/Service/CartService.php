<?php

namespace App\Service;

use App\Entity\CartItem;
use App\Entity\Product;
use App\Repository\CartItemRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
class CartService
{
    private SessionInterface $session;
    private Security $security;
    private CartItemRepository $cartItemRepository;
    private ProductRepository $productRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(
        RequestStack $requestStack,
        Security $security,
        CartItemRepository $cartItemRepository,
        ProductRepository $productRepository,
        EntityManagerInterface $entityManager
    ) {
        $this->session = $requestStack->getSession();
        $this->security = $security;
        $this->cartItemRepository = $cartItemRepository;
        $this->productRepository = $productRepository;
        $this->entityManager = $entityManager;
    }

    public function getCart(): array
    {
        $cart = [
            'items' => [],
            'subtotal' => 0,
            'shipping' => 5.00,
            'discount' => 0,
            'total' => 0
        ];

        $user = $this->security->getUser();
        if ($user) {
            $cartItems = $this->cartItemRepository->findBy(['user' => $user]);
            foreach ($cartItems as $cartItem) {
                $product = $cartItem->getProduct();
                if ($product) {
                    $itemTotal = $product->getPrice() * $cartItem->getQuantity();
                    $cart['items'][] = [
                        'product' => $product,
                        'quantity' => $cartItem->getQuantity(),
                        'total' => $itemTotal
                    ];
                    $cart['subtotal'] += $itemTotal;
                }
            }
        }

        $cart['total'] = $cart['subtotal'] + $cart['shipping'] - $cart['discount'];
        return $cart;
    }

    public function addItem(Product $product, int $quantity): void
    {
        $user = $this->security->getUser();
        if (!$user) {
            return;
        }

        $cartItem = $this->cartItemRepository->findOneBy([
            'user' => $user,
            'product' => $product
        ]);

        if ($cartItem) {
            $cartItem->setQuantity($cartItem->getQuantity() + $quantity);
        } else {
            $cartItem = new CartItem();
            $cartItem->setUser($user);
            $cartItem->setProduct($product);
            $cartItem->setQuantity($quantity);
        }

        $this->entityManager->persist($cartItem);
        $this->entityManager->flush();
    }

    public function removeItem(Product $product): void
    {
        $user = $this->security->getUser();
        if (!$user) {
            return;
        }

        $cartItem = $this->cartItemRepository->findOneBy([
            'user' => $user,
            'product' => $product
        ]);

        if ($cartItem) {
            $this->entityManager->remove($cartItem);
            $this->entityManager->flush();
        }
    }

    public function increaseQuantity(Product $product): void
    {
        $user = $this->security->getUser();
        if (!$user) {
            return;
        }

        $cartItem = $this->cartItemRepository->findOneBy([
            'user' => $user,
            'product' => $product
        ]);

        if ($cartItem && $cartItem->getQuantity() < $product->getStock()) {
            $cartItem->setQuantity($cartItem->getQuantity() + 1);
            $this->entityManager->flush();
        }
    }

    public function decreaseQuantity(Product $product): void
    {
        $user = $this->security->getUser();
        if (!$user) {
            return;
        }

        $cartItem = $this->cartItemRepository->findOneBy([
            'user' => $user,
            'product' => $product
        ]);

        if ($cartItem) {
            if ($cartItem->getQuantity() > 1) {
                $cartItem->setQuantity($cartItem->getQuantity() - 1);
                $this->entityManager->flush();
            } else {
                $this->removeItem($product);
            }
        }
    }

    public function clear(): void
    {
        $user = $this->security->getUser();
        if (!$user) {
            return;
        }

        $cartItems = $this->cartItemRepository->findBy(['user' => $user]);
        foreach ($cartItems as $cartItem) {
            $this->entityManager->remove($cartItem);
        }
        $this->entityManager->flush();
    }

    public function applyPromoCode(string $code): bool
    {

        $validCodes = [
            'WELCOME10' => 10,
            'SAVE20' => 20
        ];

        if (isset($validCodes[$code])) {
            $cart = $this->getCart();
            $discount = ($cart['subtotal'] * $validCodes[$code]) / 100;
            $this->session->set('cart_discount', $discount);
            return true;
        }

        return false;
    }


    public function add(int $id, int $quantity = 1): void
    {
        $product = $this->productRepository->find($id);
        if ($product) {
            $this->addItem($product, $quantity);
        }
    }

    public function remove(int $id): void
    {
        $product = $this->productRepository->find($id);
        if ($product) {
            $this->removeItem($product);
        }
    }

    public function update(int $id, int $quantity): void
    {
        if ($quantity <= 0) {
            $this->remove($id);
            return;
        }

        $cart = $this->session->get('cart', []);
        $cart[$id] = $quantity;
        $this->session->set('cart', $cart);
    }
}