----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2021 13:07:00
-- Design Name: 
-- Module Name: tb_jk_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_jk_ff_rst is
--  Port ( );
end tb_jk_ff_rst;

architecture Behavioral of tb_jk_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    signal s_clk                 :  STD_LOGIC;
    signal s_rst                 :  STD_LOGIC; 
    signal s_j                   :  STD_LOGIC;
    signal s_k                   :  STD_LOGIC; 
    signal s_q                   :  STD_LOGIC;
    signal s_q_bar               :  STD_LOGIC;

begin

    uut_d_ff_rst : entity work.jk_ff_rst
    port map(
        clk    => s_clk,
        rst    => s_rst,
        j      => s_j,
        k      => s_k,
        q      => s_q,
        q_bar  => s_q_bar
    );
    
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                           -- Process is suspended forever
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin    
    
        s_rst <= '0';
        wait for 12 ns;
        
        s_rst <= '1';
        wait for 20 ns;
        
        s_rst <= '0'; 
        wait for 58 ns;
        
        s_rst <= '1';
        wait for 34 ns;
        
        s_rst <= '0';
        wait for 231 ns;
        
        s_rst <= '1';
        wait for 34 ns;
        
        s_rst <= '0';
        wait for 240 ns;
        
        s_rst <= '1';
        wait for 42 ns;
        
        s_rst <= '0';
        
        wait;
    
    end process p_reset_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
        s_j <= '0';
        s_k <= '0';
        wait for 80 ns;
        assert(s_j = '0' and s_k = '0' and s_rst = '0' and s_q = '0' and s_q_bar = '1')
        report "Test failed for input values s_j = 0 and s_k = 0 after reset" severity error;
        
        s_j <= '1';
        s_k <= '0';
        wait for 10 ns;
        assert(s_j = '1' and s_k = '0' and s_rst = '0' and s_q = '1' and s_q_bar = '0')
        report "Test failed for input values s_j = 1 and s_k = 0 after rising edge" severity error;
        wait for 70 ns;
        
        s_j <= '0';
        s_k <= '1';
        wait for 2 ns;
        assert(s_j = '0' and s_k = '1' and s_rst = '0' and s_q = '1' and s_q_bar = '0')
        report "Test failed for input values s_j = 0 and s_k = 1 before rising edge" severity error;
        wait for 43 ns;
        
        s_j <= '1';
        s_k <= '1';
        wait for 50 ns;
        assert(s_j = '1' and s_k = '1' and s_rst = '0' and s_q = '1' and s_q_bar = '0')
        report "Test failed for input values s_j = 1 and s_k = 1" severity error;
        wait for 55 ns;
        
        s_j <= '0';
        s_k <= '0';
        wait for 50 ns;
        assert(s_j = '0' and s_k = '0' and s_rst = '1' and s_q = '0' and s_q_bar = '1')
        report "Test failed for input values s_j = 0 and s_k = 0 and reset 1 after rising edge" severity error;
        wait for 50 ns;
        
        s_j <= '1';
        s_k <= '0';
        wait for 100 ns;
        
        s_j <= '0';
        s_k <= '1';
        wait for 70 ns;     
        
        s_j <= '1';
        s_k <= '1';
        wait for 100 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;


end Behavioral;
