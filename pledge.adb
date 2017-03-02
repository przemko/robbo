with Robbo; use Robbo;

procedure Pledge is

   procedure Turn is
   begin

      while Wall loop
         Left;

         if Wall then
            Turn;
         end if;

         Go;
         Right;
      end loop;

   end Turn;

begin

   Read_World ("world_1");

   loop

      while not Wall loop
         Go;
      end loop;

      Turn;

   end loop;

exception

   when Outlet =>

      Print_World;

end Pledge;
