<?php

namespace App\Controller\Header;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SearchController extends AbstractController
{
    #[Route('/header/search', name: 'header_search')]
    public function index(): Response
    {
        // In a real application, this would fetch search results dynamically
        return $this->render('components/header/search.html.twig');
    }
}
