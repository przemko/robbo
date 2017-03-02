with Ada.Text_IO; use Ada.Text_IO;

package body Robbo is

   type Direction is (North, East, South, West);

   type Item_Type is (Empty, Wall, Path, Robbo);

   Curr_X : Integer := 0;
   Curr_Y : Integer := 0;
   Curr_D : Direction := North;

   World : array (-10 .. 10, -10 .. 10) of Item_Type :=
     (others => (others => Empty));

   procedure Go is
   begin
      World (Curr_X, Curr_Y) := Path;
      case Curr_D is
      when North => Curr_Y := Curr_Y + 1;
         when East => Curr_X := Curr_X + 1;
         when South => Curr_Y := Curr_Y - 1;
         when West => Curr_X := Curr_X - 1;
      end case;
      if
        Curr_X not in World'Range (1) or else
        Curr_Y not in World'Range (2)
      then
         raise Outlet;
      else
         World (Curr_X, Curr_Y) := Robbo;
      end if;
   end Go;

   procedure Left is
   begin
      case Curr_D is
         when North => Curr_D := West;
         when East => Curr_D := North;
         when South => Curr_D := East;
         when West => Curr_D := South;
      end case;
   end Left;

   procedure Right is
   begin
      case Curr_D is
         when North => Curr_D := East;
         when East => Curr_D := South;
         when South => Curr_D := West;
         when West => Curr_D := North;
      end case;
   end Right;


   function Wall return Boolean is
      X : Integer := Curr_X;
      Y : Integer := Curr_Y;
   begin
      case Curr_D is
      when North => Y := Y + 1;
         when East => X := X + 1;
         when South => Y := Y - 1;
         when West => X := X - 1;
      end case;
      return
        X in World'Range (1) and then
        Y in World'Range (2) and then
        World (X, Y) = Wall;
   end Wall;

   procedure Print_World is
   begin
      New_Line;
      Put_Line ("The World:");
      New_Line;
      for Y in reverse World'Range (2) loop
         for X in World'Range (1) loop
            case World (X, Y) is
               when Empty => Put (" ");
               when Wall => Put ("#");
               when Path => Put ("+");
               when Robbo => Put ("O");
            end case;
         end loop;
         New_Line;
      end loop;
   end Print_World;

   procedure Read_World (File_Name : String) is

      InFile : Ada.Text_IO.File_Type;
      X : Integer;
      Y : Integer;
      Char : Character;

   begin
      Curr_X := 0;
      Curr_Y := 0;
      Curr_D := North;
      World := (others => (others => Empty));
      Open (InFile, In_File, File_Name);
      Y := World'Last (2);
      loop
         X := World'First (1);
         loop
            Get (InFile, Char);
            if X <= World'Last (1) then
               case Char is
                  when ' ' =>
                     World (X, Y) := Empty;
                  when '#' =>
                     World (X, Y) := Wall;
                  when '^' | '>' | 'v' | '<' =>
                     World (X, Y) := Empty;
                     Curr_X := X;
                     Curr_Y := Y;
                     case Char is
                        when '^' => Curr_D := North;
                        when '>' => Curr_D := East;
                        when 'v' => Curr_D := South;
                        when '<' => Curr_D := West;
                        when others => null;
                     end case;
                  when others =>
                     World (X, Y) := Empty;
               end case;
            end if;
            exit when End_Of_Line (InFile);
            X := X + 1;
         end loop;
         exit when End_Of_File (InFile);
         Y := Y - 1;
         exit when Y < World'First (2);
      end loop;
      Close (InFile);
   end Read_World;

end Robbo;
