# a 32-bit single-cycle microarchitecture MIPS processor based on Harvard Architecture.
 In this project, you are required to implement a 32-bit single-cycle microarchitecture  MIPS processor based on Harvard Architecture. The single-cycle microarchitecture executes an  entire instruction in one cycle. In other words instruction fetch, instruction decode, execute,  write back, and program counter update occurs within a single clock cycle.  

Objective  
 Referring to figure one, you are required to write the RTL Verilog files for all sub-
modules of the MIPS processor (e.g. Register File, Instruction Memory, etc.). Then, 
implementing the top module of the MIPS processor. 

![image](https://user-images.githubusercontent.com/110348462/184684963-f40f7b64-5f37-4a76-beee-69e60b0749ab.png)
![image](https://user-images.githubusercontent.com/110348462/184685011-499a6283-b8cd-4e34-9512-6f55cacc5627.png)


Top Module View  
  The processor is composed of a datapath and a controller. The controller, in turn, is 
composed of the main decoder and the ALU decoder. Figure 2 shows a block diagram of the 
single-cycle MIPS processor interfaced to external memories. 

![image](https://user-images.githubusercontent.com/110348462/184685119-934a775e-56fd-4f3a-8c55-af1b085117e7.png)
![image](https://user-images.githubusercontent.com/110348462/184685137-5ab71eff-6cc6-44ba-81e6-5e4b71377b8b.png)


Main Modules  
  1) a 32-bit ALU                               4) Register File 
  2) Program Counter                            5) Data Memory  
  3) Instruction memory                         6) Control Unit  
  
  
Small Modules
  1.  Sign Extend                               3. Adder 
  2.  shift_left_twice                          4. MUX  
  
for more details, go to and read "Final Project" to learn more about the specifications of the design 
  
# Final Simulation Results  
    Program 1: GCD of 120 and 180 
  ![image](https://user-images.githubusercontent.com/110348462/184686298-caf20cf1-0370-4747-94f4-cf3890787c44.png)

    Program 2: Factorial Number of 7
   ![image](https://user-images.githubusercontent.com/110348462/184686583-c25a42c2-ed21-400d-8dca-15c50f8cc9ea.png)

    Program 3: fibonacci sequence
  ![image](https://user-images.githubusercontent.com/110348462/184686724-387f777b-eaf6-40fe-8527-61c7a6c4ffb3.png)

  
  
  
  
  
  
