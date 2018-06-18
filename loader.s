
.global loader # нужнали она здесь?
.set FLAGS,    0x0               # присвоить FLAGS = 0x0
    .set MAGIC,    0x1BADB002       	# присвоить MAGIC = 0x1BADB002       	
    .set CHECKSUM, -(MAGIC + FLAGS) 	# присвоить CHECKSUM = -(MAGIC + FLAGS)

    .align 4			# выровнять последующие данные по 4 байта
    .long MAGIC			# разместить по текущему адресу значение MAGIC
    .long FLAGS			# разместить по текущему адресу значение FLAGS
    .long CHECKSUM			# разместить по текущему адресу значение CHECKSUM

 .set STACKSIZE, 0x4000   # присвоить STACKSIZE = 0x4000
    .lcomm stack, STACKSIZE  # зарезервировать STACKSIZE байт. stack ссылается на диапазон
    .comm  mbd, 4            # зарезервировать 4 байта под переменную mdb в области COMMON
    .comm  magic, 4          # зарезервировать 4 байта под переменную magic в области COMMON

loader:
    movl  $(stack + STACKSIZE), %esp 	# инициализировать стек
    movl  %eax, magic                # записать %eax по адресу magic
    movl  %ebx, mbd                  # записать %ebx по адресу mbd
    call  main                       # вызвать функцию kmain
    cli				# отключить прерывания от оборудования
hang:
    hlt                     # остановить процессор пока не возникнет прерывание
    jmp   hang		# прыгнуть на метку hang

