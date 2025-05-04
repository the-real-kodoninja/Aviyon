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
            'bio' => "A Kodoverse pioneer weaving aether into reality.",
            'aetherRank' => 'Aether Sovereign',
            'aetherMarks' => 1000,
            'followers_count' => 5000,
            'following_count' => 200,
            'projects' => [
                ['title' => 'AI Hub', 'description' => 'Central AI platform.'],
                ['title' => 'Cloud Engine', 'description' => 'Scalable cloud solution.'],
                ['title' => 'NFT Vault', 'description' => 'Secure NFT storage.'],
                ['title' => 'Web3 Gateway', 'description' => 'Web3 access point.'],
                ['title' => 'Metaverse Core', 'description' => 'Metaverse foundation.'],
            ],
            'activities' => [
                ['description' => 'Launched AI Hub.', 'time' => '1h ago'],
                ['description' => 'Updated Cloud Engine.', 'time' => '2h ago'],
                ['description' => 'Created NFT Vault.', 'time' => '3h ago'],
                ['description' => 'Opened Web3 Gateway.', 'time' => '4h ago'],
                ['description' => 'Built Metaverse Core.', 'time' => '5h ago'],
            ],
            'nfts' => [
                ['name' => 'Aether Token', 'description' => 'Unique digital asset.'],
                ['name' => 'Cyber Blade', 'description' => 'NFT weapon.'],
                ['name' => 'Neon Shard', 'description' => 'Rare collectible.'],
                ['name' => 'Aviyon Crest', 'description' => 'Guild symbol.'],
                ['name' => 'Kodoverse Key', 'description' => 'Access token.'],
            ],
            'feed' => [
                ['content' => 'Shared a new AI breakthrough!', 'time' => '1h ago'],
                ['content' => 'Posted cloud update.', 'time' => '2h ago'],
                ['content' => 'Showcased NFT design.', 'time' => '3h ago'],
                ['content' => 'Discussed Web3 trends.', 'time' => '4h ago'],
                ['content' => 'Explored metaverse ideas.', 'time' => '5h ago'],
            ],
        ];

        return $this->render('pages/user.html.twig', [
            'user' => $user,
        ]);
    }

    #[Route('/users', name: 'users_list')]
    public function usersList(): Response
    {
        $users = [
            [
                'username' => 'sahar-hassounat',
                'title' => 'Chief Executive Officer',
                'description' => 'A trailblazing AI strategist with a PhD from MIT, Sahar leads with a vision to achieve ASI.',
            ],
            [
                'username' => 'emmanuel-moore',
                'title' => 'Founder & Chief Technology Officer',
                'description' => 'A coding prodigy and entrepreneur, Emmanuel architected the Kodoverse.',
            ],
        ];

        return $this->render('pages/users.html.twig', [
            'users' => $users,
        ]);
    }
}
