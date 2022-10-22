#------------------------------------------------------------------------------#
#                                  GENERICS                                    #
#------------------------------------------------------------------------------#

# Special variables
DEFAULT_GOAL: all
.DELETE_ON_ERROR: $(NAME)
.PHONY: all bonus clean fclean re libmlx

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
CFLAGS	=	-Wall -Werror -Wextra -O2
INCS	=	-I. -I./include -I$(LIBMLX)/include
LIBS	=	-lm -lglfw -$(LIBMLX)/libmlx42.a
RM		=	rm -rf

# Dir and file names
NAME	=	cub3D
SRCDIR	=	src/
OBJDIR	=	bin/
DEPDIR	=	include/
SRCS	=	$(wildcard $(SRCDIR)*.c) #! RBS
OBJS	=	$(patsubst $(SRCDIR)%.c,$(OBJDIR)%.o,$(SRCS))
DEP		=	$(wildcard $(DEPDIR)*.h)
LIBMLX	=	./libmlx


#------------------------------------------------------------------------------#
#                                 TARGETS                                      #
#------------------------------------------------------------------------------#

all: libmlx $(NAME)

# Generates output file
$(NAME): $(OBJS)
	$(HIDE)$(CC) $(CFLAGS) -o $@ $^

# Compiles source files into object files
$(OBJS): $(OBJDIR)%.o : $(SRCDIR)%.c $(DEP)
	$(HIDE)$(CC) $(CFLAGS) -c $< -o $@

libmlx:
	$(HIDE)$(MAKE) -C $(LIBMLX)

# Removes objects
clean:
	$(HIDE)$(RM) $(OBJS)
	$(HIDE)$(MAKE) -C $(LIBMLX) clean

# Removes objects and executables
fclean: clean
	$(HIDE)$(RM) $(NAME)
	$(HIDE)$(MAKE) -C $(LIBMLX) fclean

# Removes objects and executables and remakes
re: fclean all
