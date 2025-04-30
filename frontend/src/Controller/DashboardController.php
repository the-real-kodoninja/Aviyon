<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class DashboardController extends AbstractController
{
    #[Route('/dashboard', name: 'dashboard')]
    public function index(): Response
    {
        // Mock user data
        $user = [
            'projects_count' => 5,
            'avy_balance' => 1200.50,
            'nfts_count' => 12,
            'instances_count' => 3,
            'recent_projects' => [
                ['id' => 1, 'name' => 'NFT Gallery', 'description' => 'A virtual gallery for showcasing NFTs.'],
                ['id' => 2, 'name' => 'DeFi Dashboard', 'description' => 'A dashboard for tracking DeFi investments.'],
            ],
            'defi_activities' => [
                ['description' => 'Staked 100 AVY in liquidity pool', 'timestamp' => new \DateTime('2025-04-28')],
                ['description' => 'Swapped 0.5 ETH for 200 AVY', 'timestamp' => new \DateTime('2025-04-27')],
            ],
        ];

        // Mock usage data
        $usage = [
            'cpu' => 2.5,
            'ram' => 8,
            'storage' => 120,
        ];

        // Mock workspaces
        $workspaces = [
            [
                'id' => 'ws_001',
                'name' => 'NFT Marketplace',
                'class' => 'Premium',
                'lastWorked' => new \DateTime('2025-04-25'),
                'repo' => 'https://github.com/kodoninja/nft-marketplace',
            ],
            [
                'id' => 'ws_002',
                'name' => 'DeFi App',
                'class' => 'Standard',
                'lastWorked' => new \DateTime('2025-04-20'),
                'repo' => 'https://github.com/kodoninja/defi-app',
            ],
        ];

        // Mock social posts
        $socialPosts = [
            [
                'content' => 'Just launched a new #NFT project in the Kodoverse! Check it out @kodonomad',
                'timestamp' => new \DateTime('2025-04-29 09:00:00'),
                'likes' => 42,
            ],
            [
                'content' => 'Exploring #DeFi opportunities on Aviyon. Loving the platform!',
                'timestamp' => new \DateTime('2025-04-29 10:30:00'),
                'likes' => 78,
            ],
        ];

        return $this->render('dashboard/index.html.twig', [
            'user' => $user,
            'usage' => $usage,
            'workspaces' => $workspaces,
            'social_posts' => $socialPosts,
        ]);
    }

    #[Route('/dashboard/workspaces', name: 'dashboard_workspaces')]
    public function workspaces(): Response
    {
        // Mock workspaces
        $workspaces = [
            [
                'id' => 'ws_001',
                'name' => 'NFT Marketplace',
                'class' => 'Premium',
                'lastWorked' => new \DateTime('2025-04-25'),
                'repo' => 'https://github.com/the-real-kodoninja/Aviyon',
                'branch' => 'main',
                'env' => 'sythe_Lucifer-4182?3',
            ],
            [
                'id' => 'ws_002',
                'name' => 'DeFi App',
                'class' => 'Standard',
                'lastWorked' => new \DateTime('2025-04-20'),
                'repo' => 'https://github.com/kodoninja/defi-app',
                'branch' => 'master',
                'env' => 'sythe_Lucifer-4182?3',
            ],
        ];

        return $this->render('pages/workspaces.html.twig', [
            'workspaces' => $workspaces,
        ]);
    }

    #[Route('/dashboard/workspace/create', name: 'create_workspace')]
    public function createWorkspace(): Response
    {
        // Placeholder: In a real app, this would render a form to create a new workspace
        $this->addFlash('success', 'Workspace created successfully.');
        return $this->redirectToRoute('dashboard_workspaces');
    }

    #[Route('/branch/{workspaceId}', name: 'branch')]
    public function openBranch(string $workspaceId): Response
    {
        // Placeholder: In a real app, this would open the branch
        $this->addFlash('success', "Branch for workspace $workspaceId opened.");
        return $this->redirectToRoute('dashboard_workspaces');
    }

    #[Route('/repository/{workspaceId}', name: 'repository')]
    public function openRepository(string $workspaceId): Response
    {
        // Placeholder: In a real app, this would open the repository
        $this->addFlash('success', "Repository for workspace $workspaceId opened.");
        return $this->redirectToRoute('dashboard_workspaces');
    }

    #[Route('/remove-branch/{workspaceId}', name: 'remove_branch')]
    public function removeBranch(string $workspaceId): Response
    {
        // Placeholder: In a real app, this would remove the branch
        $this->addFlash('success', "Branch for workspace $workspaceId removed.");
        return $this->redirectToRoute('dashboard_workspaces');
    }

    #[Route('/remove-repository/{workspaceId}', name: 'remove_repository')]
    public function removeRepository(string $workspaceId): Response
    {
        // Placeholder: In a real app, this would remove the repository
        $this->addFlash('success', "Repository for workspace $workspaceId removed.");
        return $this->redirectToRoute('dashboard_workspaces');
    }

    #[Route('/dashboard/deployments', name: 'dashboard_deployments')]
    public function deployments(): Response
    {
        return $this->render('dashboard/deployments.html.twig');
    }

    #[Route('/dashboard/deployment_logs', name: 'dashboard_deployment_logs')]
    public function deploymentLogs(): Response
    {
        return $this->render('dashboard/deployment_logs.html.twig');
    }

    #[Route('/dashboard/hosting', name: 'dashboard_hosting')]
    public function hosting(): Response
    {
        return $this->render('dashboard/hosting.html.twig');
    }

    #[Route('/dashboard/hosting_analytics', name: 'dashboard_hosting_analytics')]
    public function hostingAnalytics(): Response
    {
        return $this->render('dashboard/hosting_analytics.html.twig');
    }

    #[Route('/dashboard/agents', name: 'dashboard_agents')]
    public function agents(): Response
    {
        return $this->render('dashboard/agents.html.twig');
    }

    #[Route('/dashboard/agent/edit', name: 'dashboard_agent_edit')]
    public function editAgent(): Response
    {
        return $this->render('dashboard/agent_edit.html.twig');
    }

    #[Route('/dashboard/virtual-world', name: 'dashboard_virtual_world')]
    public function virtualWorld(): Response
    {
        $featuredProjects = [
            [
                'id' => 1,
                'title' => 'Virtual Gallery',
                'description' => 'A 3D gallery showcasing NFT art collections in the Kodoverse.',
                'image' => 'virtual-gallery.jpg',
            ],
            [
                'id' => 2,
                'title' => 'Collaborative Workspace',
                'description' => 'A shared space for teams to work on projects in real-time.',
                'image' => 'collab-space.jpg',
            ],
            [
                'id' => 3,
                'title' => 'DeFi Arena',
                'description' => 'An interactive space for DeFi simulations and trading.',
                'image' => 'defi-arena.jpg',
            ],
        ];

        $leaderboard = [
            ['username' => 'kodoninja', 'score' => 1250, 'avatar' => 'kodoninja-avatar.jpg'],
            ['username' => 'kodonomad', 'score' => 980, 'avatar' => 'kodonomad-avatar.jpg'],
            ['username' => 'aviyon', 'score' => 750, 'avatar' => 'aviyon-avatar.jpg'],
        ];

        return $this->render('dashboard/virtual-world.html.twig', [
            'featured_projects' => $featuredProjects,
            'leaderboard' => $leaderboard,
        ]);
    }

    #[Route('/dashboard/virtual-world/enter', name: 'dashboard_virtual_world_enter', methods: ['GET', 'POST'])]
    public function virtualWorldEnter(Request $request): Response
    {
        $user = [
            'username' => 'kodoninja',
            'avatar' => 'kodoninja-avatar.glb',
            'avy_balance' => 1200.50,
        ];

        $environments = [
            'gallery' => [
                'name' => 'Virtual Gallery',
                'description' => 'A 3D gallery showcasing NFT art collections.',
                'preview_image' => 'gallery-preview.jpg',
            ],
            'workspace' => [
                'name' => 'Collaborative Workspace',
                'description' => 'A shared space for teams to work on projects in real-time.',
                'preview_image' => 'workspace-preview.jpg',
            ],
            'defi-arena' => [
                'name' => 'DeFi Arena',
                'description' => 'An interactive space for DeFi simulations and trading.',
                'preview_image' => 'defi-arena-preview.jpg',
            ],
        ];

        $selectedEnvironment = null;
        if ($request->isMethod('POST')) {
            $environment = $request->request->get('environment');
            if (isset($environments[$environment])) {
                $this->addFlash('success', 'You have entered the ' . $environments[$environment]['name'] . '!');
                return $this->redirectToRoute('dashboard_virtual_world');
            }
        } elseif ($request->query->has('environment')) {
            $environment = $request->query->get('environment');
            $selectedEnvironment = $environments[$environment] ?? null;
        }

        return $this->render('dashboard/virtual_world_enter.html.twig', [
            'user' => $user,
            'environments' => $environments,
            'selected_environment' => $selectedEnvironment,
        ]);
    }

    #[Route('/dashboard/virtual-project/{id}', name: 'dashboard_virtual_project')]
    public function virtualProject(string $id): Response
    {
        $projects = [
            '1' => [
                'id' => 1,
                'title' => 'Virtual Gallery',
                'description' => 'A 3D gallery showcasing NFT art collections in the Kodoverse.',
                'creator' => 'kodoninja',
                'createdAt' => new \DateTime('2025-04-20'),
                'modelUrl' => 'virtual-gallery.glb',
                'participants' => ['kodonomad', 'aviyon'],
                'chat_messages' => [
                    ['user' => 'kodonomad', 'message' => 'This gallery looks amazing!', 'timestamp' => new \DateTime('2025-04-21')],
                    ['user' => 'kodoninja', 'message' => 'Thanks! Let’s add more NFTs.', 'timestamp' => new \DateTime('2025-04-21')],
                ],
            ],
            '2' => [
                'id' => 2,
                'title' => 'Collaborative Workspace',
                'description' => 'A shared space for teams to work on projects in real-time.',
                'creator' => 'aviyon',
                'createdAt' => new \DateTime('2025-04-18'),
                'modelUrl' => 'collab-space.glb',
                'participants' => ['kodoninja', 'kodonomad'],
                'chat_messages' => [
                    ['user' => 'kodoninja', 'message' => 'Let’s schedule a meeting here.', 'timestamp' => new \DateTime('2025-04-19')],
                ],
            ],
        ];

        $project = $projects[$id] ?? null;

        if (!$project) {
            throw $this->createNotFoundException('Project not found');
        }

        return $this->render('dashboard/virtual_project.html.twig', [
            'project' => $project,
        ]);
    }

    #[Route('/dashboard/messages', name: 'dashboard_messages')]
    public function messages(): Response
    {
        return $this->render('dashboard/messages.html.twig');
    }

    #[Route('/dashboard/nimbus-ai', name: 'dashboard_nimbus_ai')]
    public function nimbusAi(): Response
    {
        return $this->render('dashboard/nimbus-ai.html.twig');
    }

    #[Route('/dashboard/marketplace', name: 'marketplace')]
    public function marketplace(): Response
    {
        // Mock NFT data
        $nfts = [
            [
                'id' => 1,
                'name' => 'Aviyon Avatar #1',
                'creator' => 'kodoninja',
                'price' => '2.5 ETH',
                'createdAt' => '2025-04-25',
                'category' => 'avatars',
                'blockchain' => 'icp',
                'modelUrl' => 'https://example.com/nft1.glb',
            ],
            [
                'id' => 2,
                'name' => 'Kodo Art #42',
                'creator' => 'aviyon',
                'price' => '1.8 ETH',
                'createdAt' => '2025-04-20',
                'category' => 'art',
                'blockchain' => 'ethereum',
                'modelUrl' => 'https://example.com/nft2.glb',
            ],
        ];

        return $this->render('dashboard/marketplace.html.twig', [
            'nfts' => $nfts,
        ]);
    }
}
