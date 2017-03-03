package Robbo is

   Outlet : exception;

   procedure Go;

   procedure Left;

   procedure Right;

   function Wall return Boolean;

   procedure Print_World;

   procedure Read_World;
   
end Robbo;
