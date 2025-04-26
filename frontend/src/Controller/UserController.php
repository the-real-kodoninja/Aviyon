<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class UserController extends AbstractController
{
    #[Route('/user/{username}', name: 'user_profile')]
    public function userProfile(string $username): Response
    {
        return $this->render('pages/user.html.twig', ['username' => $username]);
    }
}
