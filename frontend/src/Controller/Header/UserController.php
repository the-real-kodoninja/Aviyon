<?php

namespace App\Controller\Header;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class UserController extends AbstractController
{
    #[Route('/header/user', name: 'header_user')]
    public function index(): Response
    {
        // In a real application, this would fetch user data from a database
        return $this->render('components/header/user.html.twig');
    }
}
