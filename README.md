# expiration_date_sorter
`#` Out of a given list of items and their expiration dates - sort them out in a human readable manner and expose the ones that are expired or nearing expiration. This was just made to loosley track the items that we have at home (as I am very bad at remembering a large number of items and their exact expiration dates ^^").

`#` Disclaimer: Items are in Croatian since it's easier to sort them if I give them their real names, lol.

##### Examples of command output:
The shorter version: Expired, (up to) 3, 7, and 14 days
```
[torma@Meow expiration_date_script]$ ./expiration_date_hack.sh 

o  EXPIRED  items 
 !!! [02/05]  36  Days Overdue: Meggle Maslac     
 !!! [06/05]  32  Days Overdue: Senf Podravka     
 !!! [09/05]  29  Days Overdue: Svijezi Sir     
 !!! [05/06]  2  Days Overdue: Sunka u ovitku kPlus   
 !!! [06/06]  1  Days Overdue: Sunka u ovitku PIK   
 !!! [07/06]  0  Days Overdue: Jaja      

o Items that will spoil in the next [ 1 - 3 ] days.
 > [11/06]  3  Days: Kondenzirano Mlijeko Nestle    

o Items that will spoil in the next [ 4 - 7 ] days.

o Items that will spoil in the next [ 8 - 14 ] days.
 > [16/06]  8  Days: Cajna Classic Podravka
```

Longer version: Expired, (up to) 3, 7, 14, 30, and 365 days
```
[torma@Meow expiration_date_script]$ !! f
./expiration_date_hack.sh  f

o  EXPIRED  items 
 !!! [02/05]  36  Days Overdue: Meggle Maslac     
 !!! [06/05]  32  Days Overdue: Senf Podravka     
 !!! [09/05]  29  Days Overdue: Svijezi Sir     
 !!! [05/06]  2  Days Overdue: Sunka u ovitku kPlus   
 !!! [06/06]  1  Days Overdue: Sunka u ovitku PIK   
 !!! [07/06]  0  Days Overdue: Jaja      

o Items that will spoil in the next [ 1 - 3 ] days.
 > [11/06]  3  Days: Kondenzirano Mlijeko Nestle    

o Items that will spoil in the next [ 4 - 7 ] days.

o Items that will spoil in the next [ 8 - 14 ] days.
 > [16/06]  8  Days: Cajna Classic Podravka    

o Items that will spoil in the next [ 15 - 30 ] days.
 > [07/07]  29  Days: Kiselo Vrhnje     

o Items that will spoil in the next [ 31 - 365 ] days.
 > [20/07]  42  Days: Gouda Sir     
 > [01/08]  54  Days: Maggi Instant Noodles    
 > [19/08]  72  Days: Cajna Kobasica PIK    
 > [22/08]  75  Days: Ribanac Sir     
 > [24/08]  77  Days: Ribani Sir - Paska Sirana  
 > [27/08]  80  Days: Kulen Kobasica PIK    
 > [12/09]  96  Days: Meggle Maslac Namaz    
 > [17/09]  101  Days: Ribani Sir - Paska Sirana  
 > [01/10]  115  Days: Heinz Barbeque Sauce    
 > [30/10]  144  Days: Njemacki Maslac     
 > [01/11]  146  Days: Hot Heinz Ketchup    
 > [17/12]  192  Days: Tztziki Sauce     
 > [19/01]  225  Days: Oyster Sauce     
 > [01/02]  238  Days: Heinz Pomfrit Sauce    
 > [01/02]  238  Days: Yoghurt Dressing     
 > [04/02]  241  Days: Indo Mie Govedina    
 > [06/02]  243  Days: Cremino vrhnje za kuhanje   
 > [02/03]  267  Days: Zvijezda Ketchup     
 > [26/03]  291  Days: Sweet Chili Sauce    
 > [21/04]  317  Days: Zdenka Sir     
```

`#` The output is actually coloured as well which the default output does not show, here's it in a more comprehensive manner:
![Terminal Output](https://i.imgur.com/Wj1j7Gs.png)
