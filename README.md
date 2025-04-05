# Tokenized Specialized Film Music Rights System

This blockchain-based platform enables secure management of music composition rights specifically for film and media productions. By tokenizing music rights, the system creates an efficient, transparent marketplace connecting composers with filmmakers while ensuring proper attribution and compensation.

## System Overview

The Tokenized Specialized Film Music Rights platform consists of four core smart contracts:

1. **Composer Verification Contract**: Establishes authentic creator identities and credentials
2. **Composition Registration Contract**: Documents and tokenizes original musical works
3. **Usage Licensing Contract**: Facilitates permission management for film/media productions
4. **Royalty Distribution Contract**: Automates payment allocation based on actual usage

## Getting Started

### Prerequisites

- Node.js (v16.0+)
- Ethereum development environment (Truffle/Hardhat)
- Web3 library
- Crypto wallet (MetaMask or similar)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/tokenized-film-music.git
   cd tokenized-film-music
   ```

2. Install dependencies
   ```
   npm install
   ```

3. Compile smart contracts
   ```
   npx hardhat compile
   ```

4. Deploy to test network
   ```
   npx hardhat run scripts/deploy.js --network testnet
   ```

## Smart Contract Architecture

### Composer Verification Contract
Establishes a decentralized identity system for music creators, verifying credentials, performance history, and artistic identity. Prevents impersonation and builds reputation within the ecosystem.

### Composition Registration Contract
Creates non-fungible tokens (NFTs) representing unique musical compositions. Each token contains metadata about the work including style, instrumentation, duration, and sample files.

### Usage Licensing Contract
Manages rights to use compositions in films, commercials, games, and other media. Supports various licensing models including exclusive use, limited time, geographic restrictions, and synchronization rights.

### Royalty Distribution Contract
Automatically calculates and distributes payments to rights holders based on actual usage data. Supports multiple payment streams and complex royalty structures.

## Usage Examples

### Verifying a Composer
```javascript
const composerVerifier = await ComposerVerificationContract.deployed();
await composerVerifier.registerComposer(
  "Alexandra Chen",
  "0x71C7656EC7ab88b098defB751B7401B5f6d8976F",
  "https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/credentials.json"
);
```

### Registering a Composition
```javascript
const compositionRegistry = await CompositionRegistrationContract.deployed();
await compositionRegistry.registerComposition(
  "Midnight Shadows",
  "Orchestral thriller theme with electronic elements",
  "https://ipfs.io/ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/sample.mp3",
  480, // duration in seconds
  ["thriller", "orchestral", "electronic"]
);
```

## Features

- **Verifiable Ownership**: Immutable proof of composition creation and rights
- **Streamlined Licensing**: Direct connection between composers and media producers
- **Automated Royalties**: Smart contract-based payment distribution
- **Usage Analytics**: Transparent tracking of composition use across media
- **Secondary Market**: Ability to trade and transfer rights through the platform

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or support, please contact: support@tokenizedfilmmusic.org
