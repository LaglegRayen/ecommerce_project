<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(Request $request, ProductRepository $productRepository, PaginatorInterface $paginator): Response
    {
        $sort = $request->query->get('sort', 'id');
        $direction = 'ASC';


        switch ($sort) {
            case 'price_asc':
                $sort = 'p.price';
                $direction = 'ASC';
                break;
            case 'price_desc':
                $sort = 'p.price';
                $direction = 'DESC';
                break;
            case 'name':
                $sort = 'p.name';
                break;
            default:
                $sort = 'p.id';
                break;
        }

        $query = $productRepository->createQueryBuilder('p')
            ->leftJoin('p.category', 'c')
            ->orderBy($sort, $direction)
            ->getQuery();

        $products = $paginator->paginate(
            $query,
            $request->query->getInt('page', 1),
            12
        );

        return $this->render('home/index.html.twig', [
            'products' => $products,
        ]);
    }
}