

Koç University
College of Engineering
COMP 303 Computer Architecture
Fall 2019




Assignment #2
27.10.2019



Prepared by:
Arda Duman 60609
Cansu Doðanay 60601

INTRODUCTION

	The main aim of this assignment is to implement Insertion sort algorithm using MIPS assembly language in MARS Simulator. However, we are also asked to add duplicate removing and reduction to our algorithm rather than just implementing a fundamental insertion sort.

GETTING INPUT FROM THE USER
	
      At the Data_input part of the code we are simply getting an integer N, which is between 0 and 100, from the user to determine how many numbers will be entered. Since we have already had an array with 400 bytes, which is equal to 100 input size; the user is not allowed to enter more than 100 inputs. When the user gives a number to the system which is less than or equal to 0 or greater or equal to 100, it prints an error message. The number 5 at line 60, provide system to take an integer input from the user. 
      
      At the read_loop part of the code the idea is to get numbers to be sorted, from the user and fill the array with them. The user is not allowed to give different number of inputs to system. With other words, the user must enter the system with an equal number of inputs to the array size. At each line, the inputs to be sorted will asked to the user as integer number1:, integer number2: etc. This estops user to be confused. Every time the user enters an input it will be stored in the array by the loop. 
      
SORTING

	Our insertion sort algorithm consists of two nested loops. Sort_loop1 is for looking toward elements one by one and sort_loop2 is for to swap elements when an element is greater than its successor. Since it is an in-place insertion sort algorithm we are not using an auxiliary array, we are just swapping. 

DUPLICATE REMOVING

      Reduction part is also consisting of nested loops. Since we have already had a sorted list, duplicate elements can only be their neighbors. So that by looking elements one by one (sort_loop1) and comparing each element with its next element (sort_loop2) and removing it would be enough. However, after the removal, we had to decrement the size of the array. We did the process with decrement_size function. 

PRINTING LISTS

	After sorting and removing processes are ended, the system prints out both the initial sorted list and the sorted list’s duplicates are removed version. In both printing parts, since they are arrays, we are printing the sorted lists in between the symbols “[“ and “]”. 

	 After printing these sorted lists, the system is printing the sum of elements in without duplicates list. 
      When all the processes are completed, the system prints out a message that reported that program is finished running. 
      
      


