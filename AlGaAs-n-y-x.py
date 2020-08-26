
# Copyright Mfon Odungide InvasionSystemsInc invasionsystems.blogspot.com

######### global import statements  ###########
#import platform#
import math



#########  global variable declarations  ###########
const = 1239.856


#########  class declerations  ###########
class displayResult:
    dash = '==============================================='
    dott = '...............................................'
    

    def longLine(self):
        print(self.dash)
    def dots(self):
        print(self.dott)
    def result(self,*args):
        self.dots()
        print(f'''    Bandgap Energy (eV) = {args[0]:.2f} 
    Composition         = {args[1]:.2f} 
    Refractive Index    = {args[2]:.4f} 
    Wavelength (nm)     = {args[3]:.0f}''')
        self.dots()
        self.longLine()
    
    def getInput(self,phrase):
        phrase = input("")
        # phrase = input({})
        print(phrase)


#########  methods declerations  ###########

def selection():
    global const
    conc = 0
    Lambda, Eg_eV, i = 0,0, 2 #initializing variables
    
    line= displayResult()
    line.longLine()
    while (i != 0):
        sel = input('For Al(x)Ga(1-x)As, Select:\n[1] to Compute Energy Gap \n[2] to compute Wavelength \n[0] for neither \nSelection = ')
        if (sel == '1') or (i == 1):
            conc = getConc()
            Eg_eV = input('Input the Bandgap Energy in eV of Al(x)Ga(1-x)As  ')
            Lambda = const/(Eg_eV)
            break
        elif sel == '2':
            conc = getConc()
            Lambda = input('Input the Bandgap Wavelength in nm of Al(x)Ga(1-x)As  ')
            Eg_eV = const/float(Lambda)
            break
        elif sel == '0':
            Eg_eV,conc = computeEg()
            Lambda = const/float(Eg_eV)
            break
        elif (sel != '1' and sel != '2' ):
            print('''Select options [1], [2], [0] by typing 1, 2 or 0 on Keyboard
                or leave blank for default [1] selection''')

        i -= 1
        

    return float(Lambda), Eg_eV, conc 
def getConc(*args):
    concInput = input('Input the Concentration of Alumimium in Al(x)Ga(1-x)As in % ')
    conc = int(concInput) / 100
    return (conc)

def computeEg(*args):
    x = getConc() #get the input concentration
    if (x > 0.45):
        Eg = 1.9+0.125* x+0.143* x* x
    else:
        Eg = (1.424 + 1.247*x)
    return Eg, x
    
def computeN():
    Lambda, Eg_eV, x = selection() #get the computation selection
    E0 = (1.425 + (1.155 * x) + (0.37 * x * x))
    delta_E0 = (1.765 + (1.115 * x) + (0.37 * x * x))
    chi = (Eg_eV)/E0
    chio = (Eg_eV)/delta_E0
    f = (2 - ((1+chi)**0.5) - (1-chi)**0.5) / ((chi * chi))
    fo = (2 - ((1+chio)**0.5) - ((1-chio)**0.5)) /(chio*chio)
    bruch = 0.5*(E0/(delta_E0**1.5))
    A0 =6.3 + (19.0 * x)
    B0 = 9.4 - (10.2 * x)

    n1 = ((A0*(f+bruch*fo)+B0)**0.5) #swapped for testing complex conjugate
    n = (n1.real)
    # Test Parameter
    #print (f'lambda = {Lambda}, \nEg = {Eg_eV},\nA0 = {A0},\nB0 = {B0},\nx = {x}, \nf = {f},\nfo = {fo}, \nE0 = {E0}, \nn1 = {n1}, \nbruch = {bruch}, \nchi = {chi}, \nn = {n}.')
    return Eg_eV, x, n, Lambda 

######### main block  ###########

def main():

    Eg_eV, x, n, Lambda = computeN()
    disp = displayResult()
    #disp.longLine()
    disp.result(Eg_eV, x, n, Lambda) # (Eg | Conc | n | lambda)



if __name__ == '__main__': main()
