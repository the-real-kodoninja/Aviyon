<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CareersController extends AbstractController
{
    #[Route('/careers', name: 'careers')]
    public function index(): Response
    {
        return $this->render('pages/careers.html.twig');
    }

    #[Route('/careers/apply', name: 'careers_apply', methods: ['POST'])]
    public function apply(Request $request): Response
    {
        return $this->redirectToRoute('careers');
    }
}
