$PBExportHeader$w_input_gastos.srw
$PBExportComments$€
forward
global type w_input_gastos from Window
end type
type em_importe_gastos from editmask within w_input_gastos
end type
type st_78 from statictext within w_input_gastos
end type
type em_importe_rem from editmask within w_input_gastos
end type
type st_77 from statictext within w_input_gastos
end type
type uo_gasto from u_em_campo_2 within w_input_gastos
end type
type em_moneda_interes from u_em_campo within w_input_gastos
end type
type em_cta_interes from u_em_campo within w_input_gastos
end type
type em_gasto_interes from editmask within w_input_gastos
end type
type em_interes_minim from editmask within w_input_gastos
end type
type st_8 from statictext within w_input_gastos
end type
type st_23 from statictext within w_input_gastos
end type
type st_22 from statictext within w_input_gastos
end type
type st_21 from statictext within w_input_gastos
end type
type st_20 from statictext within w_input_gastos
end type
type st_4 from statictext within w_input_gastos
end type
type st_3 from statictext within w_input_gastos
end type
type sle_gasto from editmask within w_input_gastos
end type
type em_cuenta from u_em_campo within w_input_gastos
end type
type em_moneda from u_em_campo within w_input_gastos
end type
type st_7 from statictext within w_input_gastos
end type
type st_6 from statictext within w_input_gastos
end type
type st_5 from statictext within w_input_gastos
end type
type st_2 from statictext within w_input_gastos
end type
type cb_3 from commandbutton within w_input_gastos
end type
type cb_insertar from commandbutton within w_input_gastos
end type
type dw_4 from datawindow within w_input_gastos
end type
type em_apunte_banco from editmask within w_input_gastos
end type
type st_1 from statictext within w_input_gastos
end type
type dw_2 from datawindow within w_input_gastos
end type
type cb_2 from commandbutton within w_input_gastos
end type
type cb_1 from commandbutton within w_input_gastos
end type
type gb_2 from groupbox within w_input_gastos
end type
type gb_1 from groupbox within w_input_gastos
end type
end forward

global type w_input_gastos from Window
int X=306
int Y=380
int Width=2432
int Height=1352
boolean TitleBar=true
string Title="INTRODUCCIÓN DE DATOS "
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
em_importe_gastos em_importe_gastos
st_78 st_78
em_importe_rem em_importe_rem
st_77 st_77
uo_gasto uo_gasto
em_moneda_interes em_moneda_interes
em_cta_interes em_cta_interes
em_gasto_interes em_gasto_interes
em_interes_minim em_interes_minim
st_8 st_8
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_4 st_4
st_3 st_3
sle_gasto sle_gasto
em_cuenta em_cuenta
em_moneda em_moneda
st_7 st_7
st_6 st_6
st_5 st_5
st_2 st_2
cb_3 cb_3
cb_insertar cb_insertar
dw_4 dw_4
em_apunte_banco em_apunte_banco
st_1 st_1
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_input_gastos w_input_gastos

type variables
string inst_banco
integer inst_anyo
integer inst_remesa
string inst_naci_extra
string inst_tipodoc



end variables

forward prototypes
public function decimal f_calculo_timbres (string codigo, decimal nominal)
public subroutine f_calculo_total_gastos ()
end prototypes

public function decimal f_calculo_timbres (string codigo, decimal nominal);Dec{2}	top1,top2,top3,top4,top5,top6,top7,top8,top9,top10,top11,top12,top13,top14,top15
Dec{2}	tim1,tim2,tim3,tim4,tim5,tim6,tim7,tim8,tim9,tim10,tim11,tim12,tim13,tim14,tim15
Dec{2}	imptim

SELECT cartimbres.tope1,cartimbres.tope2,cartimbres.tope3,
		 cartimbres.tope4,cartimbres.tope5,cartimbres.tope6,
		 cartimbres.tope7,cartimbres.tope8,cartimbres.tope9,
		 cartimbres.tope10,cartimbres.tope11,cartimbres.tope12,
		 cartimbres.tope13,cartimbres.tope14,cartimbres.tope15,
		 cartimbres.timbre1,cartimbres.timbre2,cartimbres.timbre3,
		 cartimbres.timbre4,cartimbres.timbre5,cartimbres.timbre6,
		 cartimbres.timbre7,cartimbres.timbre8,cartimbres.timbre9,
		 cartimbres.timbre10,cartimbres.timbre11,cartimbres.timbre12,
		 cartimbres.timbre13,cartimbres.timbre14,cartimbres.timbre15
	INTO :top1,:top2,:top3,:top4,:top5,:top6,:top7,:top8,:top9,:top10,
		  :top11,:top12,:top13,:top14,:top15,
		  :tim1,:tim2,:tim3,:tim4,:tim5,:tim6,:tim7,:tim8,:tim9,:tim10,
		  :tim11,:tim12,:tim13,:tim14,:tim15	FROM cartimbres
WHERE cartimbres.codigo = :codigo USING SQLCA;

IF SQLCA.SQLCode <> 0 THEN
	RETURN 0
END IF

CHOOSE CASE nominal
	CASE is <= top1 
		imptim = tim1
	CASE top1+1 TO top2
		imptim = tim2
	CASE top2+1 TO top3
		imptim = tim3	
	CASE top3+1 TO top4
		imptim = tim4
	CASE top4+1 TO top5
		imptim = tim5
	CASE top5+1 TO top6
		imptim = tim6
	CASE top6+1 TO top7
		imptim = tim7
	CASE top7+1 TO top8
		imptim = tim8
	CASE top8+1 TO top9
		imptim = tim9
	CASE top9+1 TO top10
		imptim = tim10
	CASE top10+1 TO top11
		imptim = tim11
	CASE top11+1 TO top12
		imptim = tim12
	CASE top12+1 TO top13
		imptim = tim13
	CASE top13+1 TO top14
		imptim = tim14
	CASE IS > top14+1 
		imptim = tim15
	CASE ELSE
		imptim = 0
END CHOOSE

IF IsNull(imptim) THEN imptim = 0

RETURN imptim
end function

public subroutine f_calculo_total_gastos ();Int	i
Dec{2}	totgas

totgas = 0

FOR i = 1 To dw_2.RowCount()
	totgas = totgas + dw_2.GetItemNumber(i,"gastos")
NEXT

if em_gasto_interes.text = "" then
	totgas = totgas 
else
	totgas = totgas + Dec(em_gasto_interes.text)
end if

em_importe_gastos.text = String(totgas)


end subroutine

on w_input_gastos.create
this.em_importe_gastos=create em_importe_gastos
this.st_78=create st_78
this.em_importe_rem=create em_importe_rem
this.st_77=create st_77
this.uo_gasto=create uo_gasto
this.em_moneda_interes=create em_moneda_interes
this.em_cta_interes=create em_cta_interes
this.em_gasto_interes=create em_gasto_interes
this.em_interes_minim=create em_interes_minim
this.st_8=create st_8
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.st_4=create st_4
this.st_3=create st_3
this.sle_gasto=create sle_gasto
this.em_cuenta=create em_cuenta
this.em_moneda=create em_moneda
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_insertar=create cb_insertar
this.dw_4=create dw_4
this.em_apunte_banco=create em_apunte_banco
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.em_importe_gastos,&
this.st_78,&
this.em_importe_rem,&
this.st_77,&
this.uo_gasto,&
this.em_moneda_interes,&
this.em_cta_interes,&
this.em_gasto_interes,&
this.em_interes_minim,&
this.st_8,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.st_4,&
this.st_3,&
this.sle_gasto,&
this.em_cuenta,&
this.em_moneda,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_2,&
this.cb_3,&
this.cb_insertar,&
this.dw_4,&
this.em_apunte_banco,&
this.st_1,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.gb_2,&
this.gb_1}
end on

on w_input_gastos.destroy
destroy(this.em_importe_gastos)
destroy(this.st_78)
destroy(this.em_importe_rem)
destroy(this.st_77)
destroy(this.uo_gasto)
destroy(this.em_moneda_interes)
destroy(this.em_cta_interes)
destroy(this.em_gasto_interes)
destroy(this.em_interes_minim)
destroy(this.st_8)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_gasto)
destroy(this.em_cuenta)
destroy(this.em_moneda)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_insertar)
destroy(this.dw_4)
destroy(this.em_apunte_banco)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;string naci_extra_booleano 


// Utilizamos 2 dw

dw_2.settransobject(sqlca)		// Para mostrar los gastos y obtener el total
dw_4.settransobject(sqlca)		// Para tener los efectos. Invisible


// Estructura para pasar datos 
str_imput_gastos datos_gastos
datos_gastos = Message.powerobjectparm

// Los datos generales pasados en la estructura como variables instancia
inst_banco 		 = datos_gastos.banco
inst_anyo 		 = datos_gastos.anyo
inst_remesa 	 = datos_gastos.remesa
inst_naci_extra = datos_gastos.naci_extra
inst_tipodoc 	 = datos_gastos.tipodoc


// La dw_4 la utilizamos para tener todos los efectos de la remesa
// Es dw external, se pasan los datos con la estructura
int k,fila
dw_4.reset()

FOR k = 1 TO datos_gastos.num_efectos
	fila = dw_4.insertrow(0)
	dw_4.setitem(fila,"arg_empresa",codigo_empresa)
	dw_4.setitem(fila,"arg_anyo",inst_anyo)
	dw_4.setitem(fila,"orden",datos_gastos.efectos_orden[k])
	dw_4.setitem(fila,"fvto",datos_gastos.efectos_fvto[k])
	dw_4.setitem(fila,"importe",datos_gastos.efectos_importe[k])
NEXT




// En la tabla carremesas el campo naci_extra es "N" ó "E"
// En la tabla carefectos el campo nacional es "S" ó "N"
// En la estructura pasamos "N" ó "E"
if inst_naci_extra = "N" then 
	naci_extra_booleano = "S"
else
	naci_extra_booleano = "N"
end if

		
// Obtenemos otros datos de la remesa directamente de "CARREMESAS"
datetime la_fremesa
dec {5} el_importe,las_divisas
	
select fremesa,importe,divisas into :la_fremesa, :el_importe, :las_divisas 
from carremesas 
where empresa = :codigo_empresa and
		anyo = :inst_anyo and
		banco = :inst_banco and
		naci_extra = :inst_naci_extra and
		remesa = :inst_remesa;

// En dw_2 los gastos 
dw_2.retrieve(codigo_empresa,inst_banco,inst_tipodoc,inst_naci_extra)

// *******************************************************************+
// 	CÁLCULO DE LOS GASTOS
// ********************************************************************

// Calculamos los gastos para cada efecto
//
// 	Para cada gasto
//			Para cada efecto 
//				"Cálculo gasto"	
//			Fin para
//		Fin para

int i,j
dec {2} nominal,interes
datetime venci
dec porcent,import,gasto,total_gasto,gasto_general = 0
 

// El cálculo del gasto para cada efecto es :
// 	SI nominal * porcentaje / 100 < importe 	ENTONCES importe
//		SINO  nominal * porcentaje / 100 	
//		FIN SI
//
// El gasto 12 (Timbres) es un caso especial y se calcula a partir
//	de la tabla "CARTIMBRES"


STRING cod_gasto
// Para cada gasto
for i = 1 to dw_2.rowcount()
	
	cod_gasto = dw_2.getitemstring(i,"gasto")
	porcent 	 = dw_2.getitemnumber(i,"porcentaje")
	import 	 = dw_2.getitemnumber(i,"importe")
	
	total_gasto = 0
	// Para cada efecto
	for j = 1 to dw_4.rowcount()
		
		nominal = dw_4.getitemnumber(j,"importe")
		venci   = dw_4.getitemdatetime(j,"fvto")
		
		// El gasto 12 (timbres). El codigo de importe es la clave en "CARTIMBRES" 
		if cod_gasto = "12" then
			gasto = f_calculo_timbres(string(integer(import)),nominal) 
			total_gasto = total_gasto + gasto
			
		// Otros gastos	
		else
			gasto = nominal * porcent / 100
			if gasto < import then gasto = import
			total_gasto = total_gasto + gasto
		end if	
		
		// Cálculo de los intereses para cada efecto
		interes = f_calculo_intereses(inst_banco,inst_tipodoc,nominal,venci,la_fremesa,inst_naci_extra )
		
		dw_4.setitem(j,"interes",interes)
		
				
	next
	
	dw_2.setitem(i,"gastos",total_gasto)
	gasto_general = gasto_general + total_gasto
next

// *******************************************************************+
// 	PONER DATOS
// *********************************************************************

// Ponemos el total intereses calculados en dw_4 en campo intereses

IF dw_4.getitemnumber(1,"tot_interes") > 0 THEN
	em_gasto_interes.text = String(dw_4.getitemnumber(1,"tot_interes"))
	
	dec int_minim
	
	SELECT carbangas.cta_interes,carbangas.interesminim 
			INTO :em_cta_interes.text,:int_minim FROM carbangas
	WHERE carbangas.empresa = :codigo_empresa
	AND   carbangas.banco 	= :inst_banco	
	AND	carbangas.tipodoc = :inst_tipodoc
	AND	carbangas.naciextra	= "N" USING SQLCA;
	
	if isnull(int_minim)  then int_minim = 0
	
	em_interes_minim.text = string(int_minim)
	
ELSE
	em_gasto_interes.text = '0'
	em_cta_interes.text	 = ""
	em_interes_minim.text = ""
END IF




// Ponemos por defecto el total de la remesa en importe remesa y
// apunte al banco
em_importe_gastos.text = String(gasto_general+dw_4.getitemnumber(1,"tot_interes"))
em_importe_rem.text = string(dw_4.getitemnumber(1,"total"))
em_apunte_banco.text = string(dw_4.getitemnumber(1,"total"))




// *********************************************************************+
//		OCULTAR DATOS SEGÚN TIPO DE REMESA Y SITUACIÓN
// **********************************************************************

// El apunte al banco visible según variable de la estructura 
if datos_gastos.visible_importe = true then
	em_apunte_banco.visible = true
	st_1.visible = true
else	
	em_apunte_banco.visible = false
	st_1.visible = false
end if

// Se hace cálculo de intereses según variable de la estructura
if not datos_gastos.calcula_intereses then 
	em_gasto_interes.text= ""
	f_calculo_total_gastos()
end if

end event

type em_importe_gastos from editmask within w_input_gastos
int X=978
int Y=1036
int Width=558
int Height=88
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,###,##0.00"
MaskDataType MaskDataType=DecimalMask!
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_78 from statictext within w_input_gastos
int X=279
int Y=1052
int Width=690
int Height=76
boolean Enabled=false
string Text="Total Gastos:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_importe_rem from editmask within w_input_gastos
int X=978
int Y=936
int Width=558
int Height=88
boolean Enabled=false
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,###,##0.00"
MaskDataType MaskDataType=DecimalMask!
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_77 from statictext within w_input_gastos
int X=279
int Y=940
int Width=690
int Height=76
boolean Enabled=false
string Text="Total Remesa :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_gasto from u_em_campo_2 within w_input_gastos
event destroy ( )
int X=55
int Y=784
int Width=434
int Height=72
int TabOrder=70
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long BackColor=16777215
end type

on uo_gasto.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_gasto.em_campo.text=f_nombre_cargastos(codigo_empresa,uo_gasto.em_codigo.text)
If Trim(uo_gasto.em_campo.text)="" Then
	If Trim(uo_gasto.em_codigo.text)<>"" then uo_gasto.em_campo.SetFocus()
	uo_gasto.em_campo.text=""
	uo_gasto.em_codigo.text=""
end if
end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_cargastos"
ue_titulo     =  "AYUDA SELECCION DE TIPOS DE GASTOS"
ue_filtro     =  ""
valor_empresa = true
end event

type em_moneda_interes from u_em_campo within w_input_gastos
event getfocus pbm_ensetfocus
int X=1531
int Y=80
int Width=320
int Height=72
int TabOrder=50
Alignment Alignment=Right!
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=16777215
int TextSize=-8
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE MONEDAS"
ue_datawindow ="dw_ayuda_divisas"
ue_filtro =""

valor_empresa = false
end event

type em_cta_interes from u_em_campo within w_input_gastos
event getfocus pbm_ensetfocus
int X=1070
int Y=80
int Width=448
int Height=72
int TabOrder=40
Alignment Alignment=Right!
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=16777215
int TextSize=-8
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA DE CUENTAS CONTABLES"
ue_datawindow ="dw_ayuda_contaplan_directo"
valor_empresa = true
ue_filtro = "ejercicio = " + String(inst_anyo)
end event

type em_gasto_interes from editmask within w_input_gastos
int X=1865
int Y=80
int Width=366
int Height=72
int TabOrder=60
Alignment Alignment=Right!
boolean Border=false
string Mask="###,###,##0.00"
MaskDataType MaskDataType=DecimalMask!
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;f_calculo_total_gastos()	
end event

event losefocus;f_calculo_total_gastos()	
end event

type em_interes_minim from editmask within w_input_gastos
int X=722
int Y=80
int Width=329
int Height=72
Alignment Alignment=Right!
boolean Border=false
string Mask="###,###,##0.00"
MaskDataType MaskDataType=DecimalMask!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_input_gastos
int X=73
int Y=80
int Width=389
int Height=72
boolean Enabled=false
string Text="INTERESES"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_23 from statictext within w_input_gastos
int X=1861
int Y=4
int Width=379
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Total Gasto"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_22 from statictext within w_input_gastos
int X=1518
int Y=4
int Width=343
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Moneda"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_21 from statictext within w_input_gastos
int X=1065
int Y=4
int Width=453
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Cuenta"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_20 from statictext within w_input_gastos
int X=718
int Y=4
int Width=347
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Importe"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_input_gastos
int X=485
int Y=4
int Width=233
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="%"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_input_gastos
int X=69
int Y=4
int Width=416
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Gasto"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_gasto from editmask within w_input_gastos
int X=1317
int Y=788
int Width=375
int Height=72
int TabOrder=100
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,###,##0.00"
MaskDataType MaskDataType=DecimalMask!
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_cuenta from u_em_campo within w_input_gastos
int X=494
int Y=788
int Width=448
int Height=72
int TabOrder=80
Alignment Alignment=Right!
long BackColor=16777215
int TextSize=-8
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA DE CUENTAS CONTABLES"
ue_datawindow ="dw_ayuda_contaplan_directo"
ue_filtro      = "ejercicio = " + String(inst_anyo)

valor_empresa = true
end event

type em_moneda from u_em_campo within w_input_gastos
int X=942
int Y=788
int Width=375
int Height=72
int TabOrder=90
Alignment Alignment=Right!
long BackColor=16777215
int TextSize=-8
end type

event getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE MONEDAS"
ue_datawindow ="dw_ayuda_divisas"
ue_filtro =""

valor_empresa = false
end event

type st_7 from statictext within w_input_gastos
int X=1317
int Y=728
int Width=375
int Height=64
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Total Gasto"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_input_gastos
int X=942
int Y=728
int Width=375
int Height=64
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Moneda"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_input_gastos
int X=494
int Y=728
int Width=448
int Height=64
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Cuenta"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_input_gastos
int X=55
int Y=728
int Width=439
int Height=64
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Gasto"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_input_gastos
int X=2048
int Y=740
int Width=320
int Height=108
int TabOrder=120
string Text="Borrar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string nombre_gasto
int fila,eleccion

fila = dw_2.getrow()
nombre_gasto = dw_2.getitemstring(fila,"nom_gasto")
eleccion = messagebox("Atención"," ¿ Desea borrar el gasto "+ nombre_gasto + " ?",question!,yesno!,1)

if eleccion = 1 then
	dw_2.deleterow(fila)

	uo_gasto.em_codigo.text = ""
	uo_gasto.em_campo.text = ""
	em_cuenta.text = ""
	em_moneda.text = ""
	sle_gasto.text = ""
end if
f_calculo_total_gastos()	

end event

type cb_insertar from commandbutton within w_input_gastos
int X=1723
int Y=740
int Width=320
int Height=108
int TabOrder=110
string Text="Insertar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int 		fila,i,cuantas
Boolean	esta

// Control de datos

if uo_gasto.em_codigo.text = "" or em_cuenta.text = "" or  &
	em_moneda.text = "" or sle_gasto.text = "" then
	
	messagebox("Atención","Debe rellenar los datos antes de insertar un nuevo gasto")
	return
end if
IF Not f_existe_cuenta(inst_anyo,codigo_empresa,em_cuenta.text) THEN
	MessageBox("ERROR EN CUENTA","No existe la cuenta contable",Exclamation!)
	f_activar_campo(em_cuenta)
	RETURN
END IF

// Control para ver si ese gasto ya existe. En caso afirmativo se modifica
// con lo nuevo

esta = FALSE

FOR i = 1 TO dw_2.RowCount()
	IF dw_2.GetItemString(i,"gasto") = uo_gasto.em_codigo.text THEN
		esta = TRUE
		fila = i
	END IF
NEXT 

// linea nueva
IF Not esta THEN
	fila = dw_2.insertrow(0)
	dw_2.setrow(fila)
END IF

dw_2.setitem(fila,"gasto",uo_gasto.em_codigo.text)
dw_2.setitem(fila,"cuenta",em_cuenta.text)
dw_2.setitem(fila,"moneda",em_moneda.text)
dw_2.setitem(fila,"gastos",dec(sle_gasto.text))

dw_2.sort()


uo_gasto.em_codigo.text = ""
uo_gasto.em_campo.text = ""
em_cuenta.text = ""
em_moneda.text = ""
sle_gasto.text = ""
f_calculo_total_gastos()
end event

type dw_4 from datawindow within w_input_gastos
int X=37
int Y=212
int Width=2149
int Height=336
boolean Visible=false
string DataObject="dw_input_remesas2"
boolean LiveScroll=true
end type

type em_apunte_banco from editmask within w_input_gastos
int X=978
int Y=1140
int Width=558
int Height=88
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###,###,##0.00"
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_input_gastos
int X=279
int Y=1152
int Width=690
int Height=76
boolean Enabled=false
string Text="Apunte al Banco :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_input_gastos
int X=50
int Y=160
int Width=2304
int Height=504
string DataObject="dw_calc_gastos"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;CHOOSE CASE f_objeto_datawindow(This)
		
	case "nom_gasto","cuenta","nom_moneda","gastos","importe","porcentaje"
		
		uo_gasto.em_codigo.text = dw_2.getitemstring(row,"gasto")
		uo_gasto.em_campo.text=f_nombre_cargastos(codigo_empresa,uo_gasto.em_codigo.text)
		em_cuenta.text = dw_2.getitemstring(row,"cuenta")
		em_moneda.text = dw_2.getitemstring(row,"moneda")
		sle_gasto.text = string(dw_2.getitemnumber(row,"gastos"))
		
		dw_2.setrow(row)
		dw_2.setcolumn("gastos")
end choose
end event

event losefocus;f_calculo_total_gastos()
end event

type cb_2 from commandbutton within w_input_gastos
int X=2053
int Y=1116
int Width=320
int Height=108
int TabOrder=30
string Text="&Cancelar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// si se cancela devolvemos false en el campo correcto

str_imput_gastos datos_salida
	
datos_salida.correcto = false	
	
closewithreturn(parent,datos_salida)
end event

type cb_1 from commandbutton within w_input_gastos
int X=2057
int Y=940
int Width=320
int Height=108
int TabOrder=20
string Text="&Aceptar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int i
string cuenta_anterior,cuenta
dec gasto,gasto_acumulado

int num_cuentas

// Control si han modificado el apunte al banco, que coincida
// importe remesa - gastos = apunte al banco
IF Dec(em_apunte_banco.text) <> Dec(em_importe_rem.text) THEN
	IF Dec(em_importe_rem.text) - Dec(em_importe_gastos.text) <> Dec(em_apunte_banco.text) THEN
		MessageBox("ERROR EN IMPORTES","El apunte al banco no coincide con remesa - gastos",Exclamation!)
		f_activar_campo(em_apunte_banco)
		RETURN
	END IF
END IF


dw_2.accepttext()

// Estructura datos de salida
str_imput_gastos datos_salida


gasto_acumulado = 0
num_cuentas = 0

// Obtenemos el total de gastos por cuenta contable
if dw_2.rowcount() > 0 then
	// nº de cuentas distintas que vamos encontrando
	// Cálculo del total de los gastos para cada cuenta contable
	// Recorremos la dw_2 ordenada por cuentas sumando los gastos
	// para una cuenta
	for i = 1 to dw_2.rowcount()
		IF i = 1 THEN
			num_cuentas = 1
			cuenta_anterior = dw_2.getitemstring(1,"cuenta")
		END IF
		cuenta = dw_2.getitemstring(i,"cuenta")
		IF Not f_existe_cuenta(inst_anyo,codigo_empresa,cuenta) THEN
			MessageBox("ERROR EN CUENTA CONTABLE","La cuenta "+Trim(cuenta)+ " no existe",Exclamation!)
			datos_salida.correcto = false	
			closewithreturn(parent,datos_salida)
			RETURN
		END IF
		gasto = dw_2.getitemnumber(i,"gastos")
		
		if cuenta = cuenta_anterior then
			gasto_acumulado = gasto_acumulado + gasto
		else
			datos_salida.gastos[num_cuentas]= gasto_acumulado
			datos_salida.cuentas[num_cuentas]=cuenta_anterior
			num_cuentas = num_cuentas +1
			gasto_acumulado = gasto
															
		end if
		cuenta_anterior = cuenta
		
	next
	// falta añadir la última fila de la dw_2
	datos_salida.gastos[num_cuentas]= gasto_acumulado
	datos_salida.cuentas[num_cuentas]=cuenta


end if

//*****************************************************************
// Datos de salida
//*****************************************************************	

datos_salida.num_gastos = num_cuentas
datos_salida.importe = dec(em_importe_rem.text)

IF em_gasto_interes.text = "" then em_gasto_interes.text = "0"	

datos_salida.intereses = Dec(em_gasto_interes.text)

datos_salida.cta_intereses = em_cta_interes.text
IF Not f_existe_cuenta(inst_anyo,codigo_empresa,datos_salida.cta_intereses) and trim(em_gasto_interes.text) <> "" THEN
		MessageBox("ERROR EN CUENTA CONTABLE","La cuenta "+Trim(datos_salida.cta_intereses)+ " no existe",Exclamation!)
		datos_salida.correcto = false	
		closewithreturn(parent,datos_salida)
		RETURN
	END IF

datos_salida.importe_salida = dec(em_apunte_banco.text)	

// Calculamos el total de los gastos
dec total_gastos
total_gastos = 0
for i = 1 to num_cuentas 
	total_gastos = total_gastos + datos_salida.gastos[i]
next
// añadimos también los intereses
total_gastos = total_gastos + datos_salida.intereses	
datos_salida.total_gastos = total_gastos

// todo correcto
datos_salida.correcto = true

// cerramos la ventana y enviamos los datos
closewithreturn(parent,datos_salida)

end event

type gb_2 from groupbox within w_input_gastos
int Y=884
int Width=2400
int Height=364
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_input_gastos
int Y=668
int Width=2400
int Height=204
string Text="Inserción / Borrado de Gastos"
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

