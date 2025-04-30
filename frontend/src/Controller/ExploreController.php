<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ExploreController extends AbstractController
{
    #[Route('/explore', name: 'explore')]
    public function explore(): Response
    {
        // Mock data for trending items (replace with actual data fetching logic)
        $trending = [
            [
                'type' => 'project',
                'name' => 'Kodo Project',
                'creator' => 'kodoninja',
                'stars' => 120,
            ],
            [
                'type' => 'nft',
                'name' => 'Aviyon Avatar',
                'creator' => 'aviyon',
                'price' => '2.5 ETH',
                'modelUrl' => 'https://example.com/nft-model.glb',
            ],
            [
                'type' => 'post',
                'content' => 'Check out my new NFT collection! #Aviyon #NFT',
                'author' => 'user123',
            ],
        ];

        return $this->render('pages/explore.html.twig', [
            'trending' => $trending,
        ]);
    }
}
