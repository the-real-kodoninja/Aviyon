<?php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class AuthController extends AbstractController
{
    #[Route('/', name: 'app_root')]
    public function root(): Response
    {
        return $this->render('dashboard/index.html.twig', [
            'usage' => ['cpu' => 2, 'ram' => 4, 'storage' => 100],
            'workspaces' => [
                ['id' => 'ws1', 'name' => 'NFT Marketplace', 'class' => 'DeFi', 'lastWorked' => new \DateTime('2025-04-20'), 'repo' => 'https://github.com/kodoninja/nft-market'],
                ['id' => 'ws2', 'name' => 'AI Agent', 'class' => 'AI', 'lastWorked' => new \DateTime('2025-04-19'), 'repo' => 'https://github.com/kodoninja/ai-agent'],
            ],
            'social_posts' => [
                ['content' => 'New Python tutorials added! #Coding', 'timestamp' => new \DateTime('2025-04-18'), 'likes' => 50],
            ],
        ]);
    }

    #[Route('/landing', name: 'landing')]
    public function landing(): Response
    {
        $globalPosts = [
            [
                'platform' => 'kodonomad',
                'author' => 'Nomad Manager',
                'content' => 'New AI-powered travel itineraries are live! #TravelTech #Web3',
                'timestamp' => new \DateTime('2025-04-20 10:00:00'),
                'image' => 'post1.jpg',
                'likes' => 42,
                'comments' => [
                    ['author' => 'Traveler1', 'content' => 'Love the new itineraries!', 'timestamp' => new \DateTime('2025-04-20 10:15:00')],
                ],
            ],
            [
                'platform' => 'kodoninja',
                'author' => 'Kodo Manager',
                'content' => 'New Python tutorials added to the Coding Academy! #Coding #LearnToCode',
                'timestamp' => new \DateTime('2025-04-18 09:00:00'),
                'image' => null,
                'likes' => 50,
                'comments' => [
                    ['author' => 'Coder1', 'content' => 'Great content!', 'timestamp' => new \DateTime('2025-04-18 09:20:00')],
                ],
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

    #[Route('/marketplace', name: 'marketplace')]
    public function marketplace(): Response
    {
        return $this->render('dashboard/marketplace.html.twig', [
            'nfts' => [
                ['id' => 1, 'name' => 'Cyberpunk Avatar #1', 'creator' => 'kodoninja', 'price' => '0.5 ETH', 'createdAt' => new \DateTime('2025-04-15')],
                ['id' => 2, 'name' => 'Neon Cityscape', 'creator' => 'kodonomad', 'price' => '0.3 ETH', 'createdAt' => new \DateTime('2025-04-14')],
            ],
        ]);
    }

    #[Route('/user/{username}', name: 'user_profile')]
    public function userProfile(string $username): Response
    {
        return $this->render('pages/user.html.twig', [
            'user' => [
                'username' => $username,
                'bio' => 'Web3 developer and DeFi enthusiast.',
                'avatar' => 'build/images/' . ($username === 'emmanuel-moore' ? 'emmanuel-moore.jpg' : 'sahar-hassounat.jpg'),
                'followers' => 100,
                'following' => 50,
                'posts' => [
                    ['content' => 'Just deployed a new smart contract! #DeFi', 'timestamp' => new \DateTime('2025-04-20'), 'likes' => 10, 'comments' => []],
                ],
                'repos' => [
                    ['name' => 'NFT Marketplace', 'url' => 'https://github.com/kodoninja/nft-market', 'stars' => 120],
                ],
                'nfts' => [
                    ['id' => 1, 'name' => 'Cyberpunk Avatar #1'],
                ],
            ],
        ]);
    }

    #[Route('/about', name: 'about')]
    public function about(): Response
    {
        return $this->render('pages/about.html.twig');
    }

    #[Route('/ide', name: 'ide')]
    public function ide(): Response
    {
        return $this->render('ide/index.html.twig');
    }

    #[Route('/like', name: 'like_post', methods: ['POST'])]
    public function likePost(Request $request): Response
    {
        $postId = $request->request->get('post_id');
        return $this->json(['likes' => rand(10, 100)]);
    }

    #[Route('/comment', name: 'add_comment', methods: ['POST'])]
    public function addComment(Request $request): Response
    {
        $postId = $request->request->get('post_id');
        $content = $request->request->get('content');
        $this->addFlash('success', 'Comment added!');
        return $this->redirectToRoute('landing');
    }

    #[Route('/search', name: 'search')]
    public function search(Request $request): Response
    {
        $query = $request->query->get('q');
        $type = $request->query->get('type');
        $results = [
            ['type' => 'user', 'name' => 'kodoninja', 'url' => '/user/kodoninja'],
            ['type' => 'repo', 'name' => 'NFT Marketplace', 'url' => 'https://github.com/kodoninja/nft-market'],
            ['type' => 'post', 'content' => 'New AI tools launched! #Web3', 'url' => '/landing'],
            ['type' => 'nft', 'name' => 'Cyberpunk Avatar #2', 'url' => '/marketplace'],
        ];
        if ($type) {
            $results = array_filter($results, fn($r) => $r['type'] === $type);
        }
        return $this->render('pages/search.html.twig', [
            'query' => $query,
            'type' => $type,
            'results' => $results,
        ]);
    }

    #[Route('/explore', name: 'explore')]
    public function explore(): Response
    {
        return $this->render('pages/explore.html.twig', [
            'trending' => [
                ['type' => 'project', 'name' => 'AI Agent', 'creator' => 'kodoninja', 'stars' => 150],
                ['type' => 'nft', 'name' => 'Cyberpunk Avatar #2', 'creator' => 'kodonomad', 'price' => '0.4 ETH'],
                ['type' => 'post', 'content' => 'Join our DeFi hackathon! #Web3', 'author' => 'kodoninja'],
            ],
        ]);
    }
}
