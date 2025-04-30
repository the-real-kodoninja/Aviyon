<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MarketplaceController extends AbstractController
{
    #[Route('/marketplace', name: 'marketplace_root')]
    public function index(): Response
    {
        // Expanded NFT data for the marketplace
        $nfts = [
            [
                'id' => 1,
                'name' => 'NFT #1',
                'creator' => 'kodoninja',
                'price' => '0.5 ETH',
                'createdAt' => '2025-04-01',
                'modelUrl' => '/models/nft1.glb',
                'category' => 'art',
                'blockchain' => 'ethereum',
            ],
            [
                'id' => 2,
                'name' => 'NFT #2',
                'creator' => 'kodonomad',
                'price' => '1.2 ETH',
                'createdAt' => '2025-04-02',
                'modelUrl' => '/models/nft2.glb',
                'category' => 'avatars',
                'blockchain' => 'icp',
            ],
            [
                'id' => 3,
                'name' => 'Cyber Collectible #1',
                'creator' => 'aviyon',
                'price' => '0.8 ETH',
                'createdAt' => '2025-04-03',
                'modelUrl' => '/models/collectible1.glb',
                'category' => 'collectibles',
                'blockchain' => 'polygon',
            ],
            [
                'id' => 4,
                'name' => 'Virtual Land #101',
                'creator' => 'kodoverse',
                'price' => '2.0 ETH',
                'createdAt' => '2025-04-04',
                'modelUrl' => '/models/land101.glb',
                'category' => 'virtual-land',
                'blockchain' => 'ethereum',
            ],
            [
                'id' => 5,
                'name' => 'Anime Avatar #7',
                'creator' => 'kodoninja',
                'price' => '0.9 ETH',
                'createdAt' => '2025-04-05',
                'modelUrl' => '/models/avatar7.glb',
                'category' => 'avatars',
                'blockchain' => 'icp',
            ],
            [
                'id' => 6,
                'name' => 'Pixel Art #23',
                'creator' => 'kodonomad',
                'price' => '0.3 ETH',
                'createdAt' => '2025-04-06',
                'modelUrl' => '/models/art23.glb',
                'category' => 'art',
                'blockchain' => 'polygon',
            ],
            [
                'id' => 7,
                'name' => 'Rare Collectible #5',
                'creator' => 'aviyon',
                'price' => '1.5 ETH',
                'createdAt' => '2025-04-07',
                'modelUrl' => '/models/collectible5.glb',
                'category' => 'collectibles',
                'blockchain' => 'ethereum',
            ],
            [
                'id' => 8,
                'name' => 'Virtual Land #202',
                'creator' => 'kodoverse',
                'price' => '3.0 ETH',
                'createdAt' => '2025-04-08',
                'modelUrl' => '/models/land202.glb',
                'category' => 'virtual-land',
                'blockchain' => 'icp',
            ],
            [
                'id' => 9,
                'name' => 'Sci-Fi Avatar #3',
                'creator' => 'kodoninja',
                'price' => '1.1 ETH',
                'createdAt' => '2025-04-09',
                'modelUrl' => '/models/avatar3.glb',
                'category' => 'avatars',
                'blockchain' => 'polygon',
            ],
            [
                'id' => 10,
                'name' => 'Abstract Art #15',
                'creator' => 'kodonomad',
                'price' => '0.7 ETH',
                'createdAt' => '2025-04-10',
                'modelUrl' => '/models/art15.glb',
                'category' => 'art',
                'blockchain' => 'ethereum',
            ],
        ];

        return $this->render('pages/marketplace.html.twig', [
            'nfts' => $nfts
        ]);
    }

    #[Route('/dashboard/marketplace', name: 'marketplace')]
    public function marketplace(): Response
    {
        // Mock NFT data for the dashboard marketplace
        $nfts = [
            [
                'id' => 1,
                'name' => 'NFT #1',
                'creator' => 'kodoninja',
                'price' => '0.5 ETH',
                'createdAt' => '2025-04-01',
                'modelUrl' => '/models/nft1.glb',
                'category' => 'art',
                'blockchain' => 'ethereum',
            ],
            [
                'id' => 2,
                'name' => 'NFT #2',
                'creator' => 'kodonomad',
                'price' => '1.2 ETH',
                'createdAt' => '2025-04-02',
                'modelUrl' => '/models/nft2.glb',
                'category' => 'avatars',
                'blockchain' => 'icp',
            ],
        ];

        return $this->render('dashboard/marketplace.html.twig', [
            'nfts' => $nfts
        ]);
    }
}
