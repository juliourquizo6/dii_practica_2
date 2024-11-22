// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract pruebaNFT is ERC721URIStorage {

    uint256 tokenPrecio = 1000 gwei;
    address public propietario;

    string nombre = "PruebaNFT";
    string simbolo = "PNFT";

    mapping(address=>uint256) public tokenIDs; 
    mapping(address=>uint256) public limites;

    uint256 tokenID = 0;

    constructor () ERC721(nombre, simbolo) {
        propietario = msg.sender;
    }

    modifier onlyPropietario(){
        require(msg.sender == propietario, "No eres el propietario");
        _;
    }

    function tokenParametros(string memory tokenNombre, string memory tokenSimbolo) public {
        nombre = tokenNombre;
        simbolo = tokenSimbolo;
    }

    function tokenLimite(address account, uint256 f_limite) public onlyPropietario {
        require(f_limite >= tokenIDs[account], "Debes definir un limite superior al ya establecido.");
        limites[account] = f_limite;
    }

    function PrecioPorToken(uint256 precio) public onlyPropietario {
        tokenPrecio = precio;
    }

    function mintTokensNuevos(string[] memory tokenURIs) public payable {

        if (limites[msg.sender] == 0) {
            limites[msg.sender] = 2;
        }

        require(tokenIDs[msg.sender] + tokenURIs.length - 1 < limites[msg.sender], "Limite superado.");
        require(msg.value >=  tokenPrecio * tokenURIs.length, "Insuficiente saldo.");

        for (uint256 i = 0; i < tokenURIs.length; i++) {
            
            _mint(msg.sender, tokenID);
            _setTokenURI(tokenID, tokenURIs[i]);
            tokenIDs[msg.sender]++;
            tokenID++;
        }

        uint256 vueltas = msg.value - tokenPrecio  * tokenURIs.length;
        payable(msg.sender).transfer(vueltas);

    }

}