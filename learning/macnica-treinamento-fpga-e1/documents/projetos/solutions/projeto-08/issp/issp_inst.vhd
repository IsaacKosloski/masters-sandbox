	component issp is
		port (
			probe  : in  std_logic_vector(17 downto 0) := (others => 'X'); -- probe
			source : out std_logic_vector(1 downto 0)                      -- source
		);
	end component issp;

	u0 : component issp
		port map (
			probe  => CONNECTED_TO_probe,  --  probes.probe
			source => CONNECTED_TO_source  -- sources.source
		);

