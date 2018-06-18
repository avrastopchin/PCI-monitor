#include "printf.h"
#include "screen.h"
#include "types.h"
#include "pci.h"

void main()
{   
    clear_screen();
    printf("\n>>> Kernel start <<<\n");
    PCIScan();
}
