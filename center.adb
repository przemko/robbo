-- center.adb
--
-- Program ustawia robota na srodku prostokatnego obszaru otoczonego sciana.

with Robbo; use Robbo;

procedure Center is

   procedure Rec_Half is
   begin
      if not Wall then
         Go;
         if not Wall then
            Go;
            Rec_Half;
            Left;
            Left;
            Go;
            Left;
            Left;
         end if;
      end if;
   end Rec_Half;

   procedure Half is
   begin
      while not Wall loop
         Go;
      end loop;
      Left;
      Left;
      Rec_Half;
   end Half;

begin
   Read_World;

   Half;
   Left;
   Half;

   Print_World;

exception
   when Outlet =>
      Print_World;

end Center;
