#------------------------------------------------------------------------------#
#                                  GENERICS                                    #
#------------------------------------------------------------------------------#

# Special variables
DEFAULT_GOAL: all
.DELETE_ON_ERROR: $(NAME)
.PHONY: all bonus clean fclean re

# Hide calls
export VERBOSE	=	TRUE
ifeq ($(VERBOSE),TRUE)
	HIDE =
else
	HIDE = @
endif


#------------------------------------------------------------------------------#
#                                VARIABLES                                     #
#------------------------------------------------------------------------------#

# Compiler and flags
CC		=	gcc
CFLAGS	=	-Wall -Werror -Wextra
INCS	=	-I. -I./include
LIBS	=	-lm
RM		=	rm -rf

# Dir and file names
NAME	=	cub3D
SRCDIR	=	src/
OBJDIR	=	bin/
DEPDIR	=	include/
SRCS	=	$(wildcard $(SRCDIR)*.c) #! RBS
OBJS	=	$(patsubst $(SRCDIR)%.c,$(OBJDIR)%.o,$(SRCS))
DEP		=	$(wildcard $(DEPDIR)*.h)


#------------------------------------------------------------------------------#
#                                 TARGETS                                      #
#------------------------------------------------------------------------------#

all: $(NAME)

# Generates output file
$(NAME): $(OBJS)
	$(HIDE)$(CC) $(CFLAGS) -o $@ $^

# Compiles source files into object files
$(OBJS): $(OBJDIR)%.o : $(SRCDIR)%.c $(DEP)
	$(HIDE)$(CC) $(CFLAGS) -c $< -o $@

# Removes objects
clean:
	$(HIDE)$(RM) $(OBJS)

# Removes objects and executables
fclean: clean
	$(HIDE)$(RM) $(NAME)

# Removes objects and executables and remakes
re: fclean all
