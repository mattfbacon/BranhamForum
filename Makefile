FRONTEND := frontend
BACKEND := backend

.PHONY: all
all: frontend backend

.PHONY: frontend
frontend:
	$(MAKE) -C $(FRONTEND)/

.PHONY: backend
backend:
	$(MAKE) -C $(BACKEND)/
