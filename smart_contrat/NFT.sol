// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract pruebaNFT is ERC721URIStorage {

    uint256 tokenID = 1;
    uint256 tokenPrecio = 1000 gwei;
    //uint256 tokenPrecio = 2 ether;
    address public propietario;

    string private nombre = "PruebaNFT";
    string private simbolo = "PNFT";

    constructor () ERC721(nombre, simbolo) {
        propietario = msg.sender;
    }

    modifier onlyPropietario(){
        require(msg.sender == propietario);
        _;
    }

    function aumentarDonacion(uint256 precio) public returns(uint256) {
        // Se puede aumentar el precio base.
        tokenPrecio = precio;
        return tokenPrecio;
    }

    // El proceso de acuñacion solo lo podra realizar la direccion que haya desplegado el contrato.
    function mintTokenNuevo(string memory tokenURI) public onlyPropietario payable returns(uint256) {
        // Dinero necesario para acuñar el NFT.
        require(msg.value >= tokenPrecio, "Insuficiente saldo");
        // Se define un limite de NFTs que se pueden crear.
        require(tokenID <= 3, "Cantidad maxima de NFTs creados superado");

        // Proceso de acuñacion.
        _mint(msg.sender, tokenID);
        // Asociar URI del JSON donde esta la informacion al NFT.
        _setTokenURI(tokenID, tokenURI);

        // Si el usuario ha deposito mas dinero de lo requerido, se le dan las vueltas.
        uint256 vueltas = msg.value - tokenPrecio;
        payable(msg.sender).transfer(vueltas);

        tokenID++;

        return tokenID;
    }

}