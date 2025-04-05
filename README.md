# Decentralized Agricultural Knowledge Exchange (DAKE)

A blockchain-based platform for farmers to share specialized agricultural knowledge, document successful techniques, track climate adaptation strategies, and establish mentorship relationships.

## Overview

DAKE is a decentralized application built on the Stacks blockchain using Clarity smart contracts. It aims to solve the problem of knowledge fragmentation in agriculture by creating a trusted, accessible platform where farmers can share verified expertise and learn from each other.

## Key Features

- **Farmer Verification**: Validate farmers' experience with specific crops
- **Technique Documentation**: Record and share successful farming practices
- **Climate Adaptation Tracking**: Document strategies for adapting to changing climate conditions
- **Mentorship Matching**: Connect experienced farmers with newcomers for knowledge transfer

## Smart Contracts

### Farmer Verification Contract

This contract handles the registration and verification of farmers and their expertise:

- Register as a farmer
- Add crop experience details
- Verify other farmers' expertise
- Query farmer information and credentials

### Technique Documentation Contract

This contract allows farmers to document successful techniques:

- Document farming techniques with details and success ratings
- Vote on the effectiveness of techniques
- Search for techniques by crop type
- Get average ratings for techniques

### Climate Adaptation Contract

This contract tracks strategies for adapting to climate challenges:

- Document climate adaptation strategies
- Rate the effectiveness of strategies
- Search for strategies by climate challenge
- Get average effectiveness ratings

### Mentorship Matching Contract

This contract facilitates mentorship relationships:

- Create mentorship profiles (as mentor or mentee)
- Request mentorship from experienced farmers
- Accept or complete mentorship relationships
- Find mentors by specialty

## Getting Started

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) - Clarity development environment
- [Node.js](https://nodejs.org/) - For running tests

### Installation

1. Clone the repository:
