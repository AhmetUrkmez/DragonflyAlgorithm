Swarm <- function(N, d, lb, ub) {
    return(
        matrix(data = runif(N*d, min = lb, max = ub),
            nrow = N,
            ncol = d,
            byrow = TRUE)
        )
}

Objective <- function(swarm) {
    return(
        apply(swarm**2, 1, sum)
    )
}

DA <- function(N, d, lb, ub, iter.bound, s, a, c, f, e, w, beta) {
    swarm <- Swarm(N, d, lb, ub)
    objective <- Objective(swarm)

    f.objective <- min(objective)
    e.objective <- max(objective)

    food <- swarm[which.min(objective), , drop = FALSE]
    enemy <- swarm[which.max(objective), , drop = FALSE]

    velocity <- matrix(0, nrow = N, ncol = d)
    delta <- matrix(0, nrow = N, ncol = d)

    iter <- 1

    while(iter < iter.bound) {
        distance <- unname(as.matrix(dist(swarm, diag = TRUE, upper = TRUE)))
        neighborhood <- iter*(ub - lb)/iter.bound

        for(i in 1: N) {
            neighbor <- which(distance[i, ] < neighborhood)
            neighbor <- neighbor[-c(i)]

            if(length(neighbor) == 0) {
                numerator <- gamma(1 + beta)*sin(pi*beta/2)
                denominator <- gamma((1 + beta)/2)*beta*2**((beta - 1)/2)
                sigma <- (numerator/denominator)**(1/beta)
                levy <- .01*runif(1)*sigma/runif(1)**(1/beta)
                delta[i, ] <- levy*swarm[i, ]
            } else {
                neighbors <- swarm[neighbor, , drop = FALSE]
                neighbors_velocity <- velocity[neighbor, , drop = FALSE]
              
                extended <- matrix(rep(swarm[i, ], nrow(neighbors)), ncol = d, byrow = TRUE)
                seperation <- -apply((extended - neighbors), 2, sum)
                alignment <- apply(neighbors_velocity, 2, mean)
                cohesion <- apply(neighbors, 2, mean) - swarm[i, ]

                velocity[i, ] <- s*seperation + a*alignment + c*cohesion
                velocity[velocity > (ub - lb)/2] <- (ub - lb)/2
                velocity[velocity < (lb - ub)/2] <- (lb - ub)/2

                food_way <- food - swarm[i, ]
                enemy_way <- enemy + swarm[i, ]

                delta[i, ] <- velocity[i, ] + f*food_way + e*enemy_way + w*delta[i, ]
            }
        }

        swarm <- swarm + delta
        swarm[swarm > ub] <- ub
        swarm[swarm < lb] <- lb
        
        objective <- Objective(swarm)

        if(min(objective) < f.objective) {
            f.objective <- min(objective)
            food <- swarm[which(f.objective == objective), ]
            if(length(food) > d) {
                food <- food[1, ]
            }
        }

        if(max(objective) > e.objective) {
            e.objective <- max(objective)
            enemy <- swarm[which(e.objective == objective), ]
            if(length(enemy) > d) {
                enemy <- enemy[1, ]
            }
        }
 
        iter <- iter + 1
    }

    return(list("food" = food,
                "food.objective" = f.objective,
                "iteration" = iter))
}

DA(30, 8, -5, 5, 500, 0.3, 0.3, 0.3, 0.5, 0.001, 0.1, 1.7)

Benchmark <- function(...) {
    fitness_values <- numeric(100)
    pb <- progress::progress_bar$new(
        format = "[:bar] :percent",
        total = 100, clear = FALSE, width = 60
        )

    start <- Sys.time()

    for(i in 1: 100) {
        fitness_values[i] <- DA(30, 8, -5, 5, 500, 0.3, 0.3, 0.3, 0.5, 0.001, 0.1, 1.7)$food.objective
        pb$tick()
    }
    
    end <- Sys.time()

    return(list("mean.fitness" = mean(fitness_values),
                "var.fitness" = var(fitness_values),
                "min.fitness" = min(fitness_values),
                "max.fitness" = max(fitness_values),
                "time" = c(end-start)))
}

Benchmark()
