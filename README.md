# VotePreferences

My personal project, just implementing a library for which one can simulate and analyze different electoral systems. Once I learn more about electoral/voting theory, I will have more to say.

This project was inspired by the following problem, which comes from the election process for the student dance company I was a member of in undergrad:

Consider an election where you have $N_o$ offices and $N_c$ candidates for these offices, and a voting population of $M$. For each office $o_i,$ voters vote for any *subset* of the candidates $\{c_i\},$ for which order matters (i.e., election theory over combinatorial domains). Moreover, the election process includes an ordering of the offices $\{o_i\}$ such that if a candidate $c_i$ is already elected to an office $i,$ they are immediately eliminated from any other elections $j$ with $j > i$ in the ordering (e.g., the president-elect is eliminated from the vice presidential election).

What is a voting system that attains an electoral outcome which is "ideal" in some sense while also being simple enough to implement using e.g., Google Forms?