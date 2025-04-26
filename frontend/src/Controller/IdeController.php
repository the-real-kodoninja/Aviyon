<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class IdeController extends AbstractController
{
    #[Route('/ide', name: 'ide')]
    public function index(): Response
    {
        return $this->render('ide/index.html.twig');
    }

    #[Route('/np-plus-plus', name: 'np_plus_plus')]
    public function npPlusPlus(): Response
    {
        return $this->render('ide/index.html.twig');
    }
}
