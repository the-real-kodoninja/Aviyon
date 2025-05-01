<?php

namespace App\Controller\Header;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MainmenuController extends AbstractController
{
    #[Route('/header/mainmenu', name: 'header_mainmenu')]
    public function index(): Response
    {
        return $this->render('components/header/mainmenu.html.twig');
    }
}
