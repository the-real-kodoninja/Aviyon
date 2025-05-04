<?php

namespace App\Controller\User;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HeaderController extends AbstractController
{
    #[Route('/user/{username}/header', name: 'user_header')]
    public function index(?string $username): Response
    {
        $user = ['username' => $username ?: 'default-user'];
        return $this->render('components/user/header.html.twig', ['user' => $user]);
    }
}
