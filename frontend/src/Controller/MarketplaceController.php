<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MarketplaceController extends AbstractController
{
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
                'modelUrl' => '/models/nft1.glb' // Add the expected modelUrl
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
}
