<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class InvestingController extends AbstractController
{
    #[Route('/investing', name: 'investing')]
    public function index(): Response
    {
        return $this->render('pages/investing.html.twig');
    }

    #[Route('/investing/non-equity/submit', name: 'investing_non_equity_submit', methods: ['POST'])]
    public function submitNonEquity(Request $request): Response
    {
        // Handle non-equity investment form submission
        return $this->redirectToRoute('investing');
    }

    #[Route('/investing/equity/submit', name: 'investing_equity_submit', methods: ['POST'])]
    public function submitEquity(Request $request): Response
    {
        // Handle equity investment form submission
        return $this->redirectToRoute('investing');
    }
}
