<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AuthController extends AbstractController
{
    #[Route('/', name: 'app_root')]
    public function root(): Response
    {
        $globalPosts = [
            [
                'id' => 1,
                'author' => 'kodoninja',
                'content' => 'Just launched my new DApp on the Kodoverse! Check it out.',
                'timestamp' => new \DateTime('2025-04-20 10:00:00'),
                'likes' => 42,
                'comments' => [],
                'image' => 'post1.jpg',
                'platform' => 'KodoNinja'
            ],
            [
                'id' => 2,
                'author' => 'kodonomad',
                'content' => 'Exploring the NFT marketplace on Aviyon. So many cool assets!',
                'timestamp' => new \DateTime('2025-04-20 12:30:00'),
                'likes' => 78,
                'comments' => [],
                'image' => null,
                'platform' => 'Marketplace'
            ],
        ];

        return $this->render('pages/landing.html.twig', [
            'global_posts' => $globalPosts,
        ]);
    }

    #[Route('/landing', name: 'landing')]
    public function landing(): Response
    {
        $globalPosts = [
            [
                'id' => 1,
                'author' => 'kodoninja',
                'content' => 'Just launched my new DApp on the Kodoverse! Check it out.',
                'timestamp' => new \DateTime('2025-04-20 10:00:00'),
                'likes' => 42,
                'comments' => [],
                'image' => 'post1.jpg',
                'platform' => 'KodoNinja'
            ],
            [
                'id' => 2,
                'author' => 'kodonomad',
                'content' => 'Exploring the NFT marketplace on Aviyon. So many cool assets!',
                'timestamp' => new \DateTime('2025-04-20 12:30:00'),
                'likes' => 78,
                'comments' => [],
                'image' => null,
                'platform' => 'Marketplace'
            ],
        ];

        return $this->render('pages/landing.html.twig', [
            'global_posts' => $globalPosts,
        ]);
    }

    #[Route('/login', name: 'login')]
    public function login(): Response
    {
        return $this->render('auth/login.html.twig');
    }

    #[Route('/signup', name: 'signup')]
    public function signup(): Response
    {
        return $this->render('auth/signup.html.twig');
    }

    #[Route('/logout', name: 'logout')]
    public function logout(): Response
    {
        return $this->redirectToRoute('app_root');
    }

    #[Route('/password/reset', name: 'password_reset')]
    public function passwordReset(): Response
    {
        return $this->render('auth/reset.html.twig');
    }

    #[Route('/reset', name: 'reset', methods: ['POST'])]
    public function reset(Request $request): Response
    {
        // Placeholder for password reset logic (e.g., validate token, update password)
        $this->addFlash('success', 'Password reset successfully!');
        return $this->redirectToRoute('login');
    }

    #[Route('/2fa/verify', name: '2fa_verify', methods: ['POST'])]
    public function verify2FA(Request $request): Response
    {
        return $this->redirectToRoute('dashboard');
    }

    #[Route('/docs', name: 'docs')]
    public function docs(): Response
    {
        return $this->render('pages/docs.html.twig');
    }

    #[Route('/dashboard/marketplace', name: 'marketplace')]
    public function marketplace(): Response
    {
        // Mock NFT data for the marketplace
        $nfts = [
            [
                'id' => 1,
                'name' => 'NFT #1',
                'creator' => 'kodoninja',
                'price' => '0.5 ETH',
                'createdAt' => '2025-04-01',
                'modelUrl' => '/models/nft1.glb'
            ],
            [
                'id' => 2,
                'name' => 'NFT #2',
                'creator' => 'kodonomad',
                'price' => '1.2 ETH',
                'createdAt' => '2025-04-02',
                'modelUrl' => '/models/nft2.glb'
            ]
        ];

        return $this->render('dashboard/marketplace.html.twig', [
            'nfts' => $nfts
        ]);
    }

    #[Route('/about', name: 'about')]
    public function about(): Response
    {
        return $this->render('pages/about.html.twig');
    }

    #[Route('/dashboard/deploy', name: 'deploy_app', methods: ['POST'])]
    public function deployApp(Request $request): Response
    {
        // Placeholder for deployment logic
        return $this->redirectToRoute('dashboard_deployments');
    }

    #[Route('/user/{username}', name: 'user_profile')]
    public function userProfile(string $username): Response
    {
        return $this->render('pages/user.html.twig', [
            'username' => $username,
        ]);
    }

    #[Route('/explore', name: 'explore')]
    public function explore(): Response
    {
        $trending = [
            [
                'title' => 'New DApp Launch',
                'author' => 'kodoninja',
                'likes' => 120,
                'platform' => 'KodoNinja',
            ],
            [
                'title' => 'NFT Drop on Aviyon',
                'author' => 'kodonomad',
                'likes' => 85,
                'platform' => 'Marketplace',
            ],
        ];

        return $this->render('pages/explore.html.twig', [
            'trending' => $trending,
        ]);
    }

    #[Route('/platform/{platformName}', name: 'platform', methods: ['GET'])]
    public function platform(string $platformName): Response
    {
        return $this->render('pages/platform.html.twig', [
            'platformName' => $platformName,
        ]);
    }

    #[Route('/search', name: 'search', methods: ['GET'])]
    public function search(Request $request): Response
    {
        return $this->render('pages/search.html.twig');
    }

    #[Route('/comment', name: 'add_comment', methods: ['POST'])]
    public function addComment(Request $request): Response
    {
        // Placeholder for adding a comment
        return $this->redirectToRoute('app_root');
    }

    #[Route('/like', name: 'like_post', methods: ['POST'])]
    public function likePost(Request $request): Response
    {
        // Placeholder for liking a post
        return $this->redirectToRoute('app_root');
    }

    #[Route('/domain/register', name: 'register_domain', methods: ['POST'])]
    public function registerDomain(Request $request): Response
    {
        // Placeholder for domain registration logic
        return $this->redirectToRoute('app_root');
    }

    #[Route('/ide', name: 'ide')]
    public function ide(): Response
    {
        return $this->render('ide/index.html.twig');
    }
}
