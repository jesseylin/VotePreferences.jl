using VotePreferences

function castballot(voter::VotePreference)
	return vec([index[1] for index in argmax(voter.prefvecs; dims=1)])
end

function countvotes!(counts, votes)
	@assert size(votes, 1) == size(counts, 1)
	num_offices, num_candidates = size(counts)
	for i in 1:num_offices, j in 1:num_candidates
		counts[i,j] = count(x -> x==j, votes[i,:])
	end
	return counts
end

function determinewinner!(outcome, counts)
	for (i, office) in enumerate(outcome)
		tally = deepcopy(counts[i, :])
		winner = argmax(tally)
		while winner in outcome
			deleteat!(tally, winner)
			winner = argmax(tally)
		end
		
		# first past the post does not break ties by default
		# but, let's silently ignore it for now
		if count(x -> x == counts[i,:][winner], counts[i, :]) > 1
			println("Silently ignoring a tie.")
			#throw(ErrorException("Cannot handle ties."))
		end
		
		outcome[i] = winner
	end
	return outcome
end

function election(voters::Vector{VotePreference})
	num_offices = size(voters[1].prefvecs, 2)
	num_voters = length(voters)
	
	votes = Array{Int}(undef, num_offices, num_voters)
	for (i, voter) in enumerate(voters)
		vote = castballot(voter)
		votes[:, i] = vote
	end
	counts = Array{Int}(undef, num_offices, num_candidates)
	countvotes!(counts, votes)

	outcome = Vector{Int}(undef, num_offices)
	determinewinner!(outcome, counts)
	return outcome
end