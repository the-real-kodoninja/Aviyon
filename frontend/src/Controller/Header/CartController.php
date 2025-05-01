<?php

namespace App\Controller\Header;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CartController extends AbstractController
{
    #[Route('/header/cart', name: 'header_cart')]
    public function index(): Response
    {
        // In a real application, this would fetch cart items from a database
        return $this->render('components/header/cart.html.twig');
    }
}
