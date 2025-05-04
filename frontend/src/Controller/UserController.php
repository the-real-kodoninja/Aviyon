<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class UserController extends AbstractController
{
    #[Route('/user/{username}', name: 'user_profile', defaults: ['username' => null])]
    public function userProfile(?string $username): Response
    {
        if ($username === null) {
            return $this->redirectToRoute('user_profile', ['username' => 'default-user']);
        }

        $user = [
            'username' => $username,
            'handle' => strtolower($username),
            'bio' => "A Kodoverse pioneer.",
            'aetherRank' => 'Aether Sovereign',
            'aetherMarks' => 1000,
            'projects_count' => 15,
            'followers_count' => 5000,
            'following_count' => 200,
            'projects' => [],
            'activities' => [],
            'nfts' => [],
            'feed' => [],
        ];

        return $this->render('pages/user.html.twig', [
            'user' => $user,
        ]);
    }
}
