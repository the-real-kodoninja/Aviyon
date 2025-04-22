<?php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MarketplaceController extends AbstractController
{
    #[Route('/marketplace', name: 'marketplace')]
    public function index(): Response
    {
        $nfts = [
            ['id' => 1, 'name' => 'Neon Samurai', 'creator' => 'kodoninja', 'price' => '0.5', 'currency' => 'ICP', 'createdAt' => new \DateTime('2025-04-01'), 'modelUrl' => '/models/samurai.glb', 'description' => 'A cyberpunk samurai avatar.'],
            ['id' => 2, 'name' => 'Ghost Shell', 'creator' => 'nimbus', 'price' => '1.2', 'currency' => 'ETH', 'createdAt' => new \DateTime('2025-04-02'), 'modelUrl' => '/models/ghost.glb', 'description' => 'Inspired by Ghost in the Shell.'],
            ['id' => 3, 'name' => 'Kodo Dragon', 'creator' => 'kodocity', 'price' => '0.8', 'currency' => 'ICP', 'createdAt' => new \DateTime('2025-04-03'), 'modelUrl' => '/models/dragon.glb', 'description' => 'A mythical dragon for the kodoverse.'],
            ['id' => 4, 'name' => 'Cyber Ninja', 'creator' => 'velocity', 'price' => '0.6', 'currency' => 'ETH', 'createdAt' => new \DateTime('2025-04-04'), 'modelUrl' => '/models/ninja.glb', 'description' => 'Stealthy ninja avatar.'],
            ['id' => 5, 'name' => 'Star Voyager', 'creator' => 'kodoplanet', 'price' => '0.9', 'currency' => 'ICP', 'createdAt' => new \DateTime('2025-04-05'), 'modelUrl' => '/models/voyager.glb', 'description' => 'Explore the cosmos.'],
            ['id' => 6, 'name' => 'Anime Hacker', 'creator' => 'kodoanime', 'price' => '0.7', 'currency' => 'ETH', 'createdAt' => new \DateTime('2025-04-06'), 'modelUrl' => '/models/hacker.glb', 'description' => 'Anime-style coder.'],
            ['id' => 7, 'name' => 'Fitness Guru', 'creator' => 'kodofitness', 'price' => '0.4', 'currency' => 'ICP', 'createdAt' => new \DateTime('2025-04-07'), 'modelUrl' => '/models/guru.glb', 'description' => 'Fitness coach avatar.'],
            ['id' => 8, 'name' => 'Nomad Explorer', 'creator' => 'kodonomad', 'price' => '0.5', 'currency' => 'ETH', 'createdAt' => new \DateTime('2025-04-08'), 'modelUrl' => '/models/explorer.glb', 'description' => 'For the digital nomad.'],
            ['id' => 9, 'name' => 'Eco Warrior', 'creator' => 'kodoplanet', 'price' => '0.6', 'currency' => 'ICP', 'createdAt' => new \DateTime('2025-04-09'), 'modelUrl' => '/models/warrior.glb', 'description' => 'Fight for sustainability.'],
            ['id' => 10, 'name' => 'Chess Master', 'creator' => 'chess.social', 'price' => '0.3', 'currency' => 'ETH', 'createdAt' => new \DateTime('2025-04-10'), 'modelUrl' => '/models/chess.glb', 'description' => 'Chess champion avatar.'],
        ];

        return $this->render('dashboard/marketplace.html.twig', [
            'nfts' => $nfts,
        ]);
    }
}
