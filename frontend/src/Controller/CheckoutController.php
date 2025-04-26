<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CheckoutController extends AbstractController
{
    #[Route('/checkout', name: 'checkout')]
    public function index(): Response
    {
        return $this->render('pages/checkout.html.twig');
    }

    #[Route('/checkout/process', name: 'checkout_process', methods: ['POST'])]
    public function process(Request $request): Response
    {
        return $this->redirectToRoute('dashboard');
    }
}
