# Multi-core embedded SoC
Efabless tape out for gf 180, Shuttle 1.
This project has 10 16-bit microprocessors. Each of them is instructionn set architecture.
Each processor has a private memory. Each memory is 512 word, each word is 16-bit wide.
Six processors are connected tochip boundary. Each of them access 8 IOs.
Four processors are connected to serial protocol hub. Each of them is connected to an SPI ip.
There are four SPI ips  in the hub. Each SPI ip access 1 IO of the chip boundary.
