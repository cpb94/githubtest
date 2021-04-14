$PBExportHeader$w_list_anticipos_prorroga.srw
forward
global type w_list_anticipos_prorroga from w_int_con_empresa
end type
type pb_1 from upb_salir within w_list_anticipos_prorroga
end type
type em_anyo from editmask within w_list_anticipos_prorroga
end type
type st_8 from statictext within w_list_anticipos_prorroga
end type
type em_vencimiento from u_em_campo within w_list_anticipos_prorroga
end type
type em_plazo_real from u_em_campo within w_list_anticipos_prorroga
end type
type st_9 from statictext within w_list_anticipos_prorroga
end type
type st_nombre_banco from statictext within w_list_anticipos_prorroga
end type
type dw_1 from datawindow within w_list_anticipos_prorroga
end type
type cb_consultar from commandbutton within w_list_anticipos_prorroga
end type
type cb_marcar from commandbutton within w_list_anticipos_prorroga
end type
type cb_desmarcar from commandbutton within w_list_anticipos_prorroga
end type
type gb_33 from groupbox within w_list_anticipos_prorroga
end type
type gb_3 from groupbox within w_list_anticipos_prorroga
end type
type gb_2 from groupbox within w_list_anticipos_prorroga
end type
type gb_1 from groupbox within w_list_anticipos_prorroga
end type
type pb_cartas from picturebutton within w_list_anticipos_prorroga
end type
type st_5 from statictext within w_list_anticipos_prorroga
end type
type dw_listado from datawindow within w_list_anticipos_prorroga
end type
type em_banco from u_em_campo within w_list_anticipos_prorroga
end type
type em_fecha from editmask within w_list_anticipos_prorroga
end type
end forward

global type w_list_anticipos_prorroga from w_int_con_empresa
int Width=2907
int Height=1596
pb_1 pb_1
em_anyo em_anyo
st_8 st_8
em_vencimiento em_vencimiento
em_plazo_real em_plazo_real
st_9 st_9
st_nombre_banco st_nombre_banco
dw_1 dw_1
cb_consultar cb_consultar
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
gb_33 gb_33
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
pb_cartas pb_cartas
st_5 st_5
dw_listado dw_listado
em_banco em_banco
em_fecha em_fecha
end type
global w_list_anticipos_prorroga w_list_anticipos_prorroga

type variables
string filtro

editmask isle_campo

integer var_ejercicio
string es_nacional
boolean inst_nuevo
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Carta prórroga de Anticipos"
This.title=istr_parametros.s_titulo_ventana


dw_1.settransobject(sqlca)
dw_listado.settransobject(sqlca)

em_anyo.text = string(year(today()))

pb_cartas.enabled = false
em_fecha.text = string(today())







end event

on w_list_anticipos_prorroga.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.em_anyo=create em_anyo
this.st_8=create st_8
this.em_vencimiento=create em_vencimiento
this.em_plazo_real=create em_plazo_real
this.st_9=create st_9
this.st_nombre_banco=create st_nombre_banco
this.dw_1=create dw_1
this.cb_consultar=create cb_consultar
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
this.gb_33=create gb_33
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.pb_cartas=create pb_cartas
this.st_5=create st_5
this.dw_listado=create dw_listado
this.em_banco=create em_banco
this.em_fecha=create em_fecha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.em_anyo
this.Control[iCurrent+3]=this.st_8
this.Control[iCurrent+4]=this.em_vencimiento
this.Control[iCurrent+5]=this.em_plazo_real
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.st_nombre_banco
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.cb_consultar
this.Control[iCurrent+10]=this.cb_marcar
this.Control[iCurrent+11]=this.cb_desmarcar
this.Control[iCurrent+12]=this.gb_33
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.pb_cartas
this.Control[iCurrent+17]=this.st_5
this.Control[iCurrent+18]=this.dw_listado
this.Control[iCurrent+19]=this.em_banco
this.Control[iCurrent+20]=this.em_fecha
end on

on w_list_anticipos_prorroga.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.em_anyo)
destroy(this.st_8)
destroy(this.em_vencimiento)
destroy(this.em_plazo_real)
destroy(this.st_9)
destroy(this.st_nombre_banco)
destroy(this.dw_1)
destroy(this.cb_consultar)
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
destroy(this.gb_33)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.pb_cartas)
destroy(this.st_5)
destroy(this.dw_listado)
destroy(this.em_banco)
destroy(this.em_fecha)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_list_anticipos_prorroga
int X=2181
int Y=32
int Width=485
int TabOrder=0
end type

type st_empresa from w_int_con_empresa`st_empresa within w_list_anticipos_prorroga
int X=9
int Y=4
int Width=2427
int Height=88
boolean BringToTop=true
end type

type pb_1 from upb_salir within w_list_anticipos_prorroga
int X=2706
int Y=16
int Width=146
int Height=136
int TabOrder=0
end type

type em_anyo from editmask within w_list_anticipos_prorroga
int X=1467
int Y=180
int Width=192
int Height=88
int TabOrder=60
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="yyyy"
MaskDataType MaskDataType=DateTimeMask!
string DisplayData="x"
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_list_anticipos_prorroga
int X=2958
int Y=324
int Width=416
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Vencimiento :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_vencimiento from u_em_campo within w_list_anticipos_prorroga
int X=3378
int Y=332
int Width=270
int TabOrder=0
Alignment Alignment=Right!
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
string DisplayData=""
boolean DisplayOnly=true
end type

type em_plazo_real from u_em_campo within w_list_anticipos_prorroga
int X=3442
int Y=424
int Width=206
int TabOrder=0
Alignment Alignment=Right!
boolean Border=false
BorderStyle BorderStyle=StyleBox!
string Mask="##0"
MaskDataType MaskDataType=NumericMask!
string DisplayData="0"
boolean DisplayOnly=true
end type

type st_9 from statictext within w_list_anticipos_prorroga
int X=2935
int Y=424
int Width=379
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Plazo Real :"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_nombre_banco from statictext within w_list_anticipos_prorroga
int X=393
int Y=196
int Width=910
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_list_anticipos_prorroga
int X=41
int Y=356
int Width=2821
int Height=860
int TabOrder=120
boolean BringToTop=true
string DataObject="dw_list_anticipos_prorroga"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_consultar from commandbutton within w_list_anticipos_prorroga
int X=2277
int Y=168
int Width=329
int Height=108
int TabOrder=70
boolean BringToTop=true
string Text="Consultar"
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int registros ,i,situ
registros = dw_1.retrieve(codigo_empresa,em_banco.text,integer(em_anyo.text))

// Por defecto ponemos como punteado el que tiene situación 0 (no listado)
if registros > 0 then
	pb_cartas.enabled = true
	

else
	pb_cartas.enabled = false
	
	
end if


end event

type cb_marcar from commandbutton within w_list_anticipos_prorroga
int X=41
int Y=1216
int Width=366
int Height=76
int TabOrder=100
boolean BringToTop=true
string Text="Marcar"
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int i
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i,"punt","S")	
	
next
end event

type cb_desmarcar from commandbutton within w_list_anticipos_prorroga
int X=411
int Y=1216
int Width=366
int Height=76
int TabOrder=80
boolean BringToTop=true
string Text="Desmarcar"
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int i
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i,"punt","N")	
	
next
end event

type gb_33 from groupbox within w_list_anticipos_prorroga
int X=1792
int Y=104
int Width=425
int Height=204
int TabOrder=30
string Text="Fecha carta"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_list_anticipos_prorroga
int X=2217
int Y=104
int Width=443
int Height=204
int TabOrder=50
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_list_anticipos_prorroga
int X=1349
int Y=104
int Width=443
int Height=204
int TabOrder=40
string Text="Año Anticipo"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_list_anticipos_prorroga
int X=59
int Y=104
int Width=1289
int Height=204
int TabOrder=20
string Text="Banco Anticipo"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_cartas from picturebutton within w_list_anticipos_prorroga
event clicked pbm_bnclicked
int X=2345
int Y=1268
int Width=174
int Height=152
int TabOrder=90
boolean BringToTop=true
string PictureName="\bmp\imp32.bmp"
string DisabledName="\bmp\imp32_no.bmp"
Alignment HTextAlign=Left!
boolean OriginalSize=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int i,cuantos,opci
string punte

cuantos = 0
for i = 1 to dw_1.rowcount()
	punte = dw_1.getitemstring(i,"punt")
	if punte = "S" then
		cuantos = cuantos + 1
	end if
next


if not isdate(em_fecha.text) then
	messagebox("Error de datos","Introduzca la fecha de la carta")
	return
end if




if cuantos >0 then
	
	opci = messagebox("Atención","¿ Desea imprimir la CABECERA en la carta ?",question!,yesno!,1)
				
else
	f_mensaje("Atención","NO hay ANTICIPOS seleccionados ")
	return
end if


// Si se quiere imprimir la cabecera
string cabecera
if opci = 1 then
	cabecera = "S"
else	
	cabecera = "N"
end if



//***********************************************************************
// IMPRESIÓN ANTICIPOS
// **********************************************************************



for i = 1 to dw_1.rowcount()
	punte = dw_1.getitemstring(i,"punt")
	if punte = "S" then
		int el_anyo,la_prorroga,el_contador
		string el_banco
		date  nuevo_venci
		el_anyo = dw_1.getitemnumber(i,"anyo")
		el_banco = dw_1.getitemstring(i,"bancofinan")
		la_prorroga = dw_1.getitemnumber(i,"num_prorroga")
		el_contador = dw_1.getitemnumber(i,"contador")
		nuevo_venci = date(dw_1.getitemdatetime(i,"vencimiento"))
		
		dw_listado.retrieve(codigo_empresa,el_anyo,el_banco,la_prorroga,el_contador,cabecera,nuevo_venci,datetime(date(em_fecha.text)))		
		f_imprimir_datawindow(dw_listado)
		//DW_LISTADO.PRINT()
	end if
	
	
next


end event

type st_5 from statictext within w_list_anticipos_prorroga
int X=1783
int Y=1304
int Width=535
int Height=76
boolean Enabled=false
string Text="Carta de Prórroga"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_listado from datawindow within w_list_anticipos_prorroga
int X=754
int Y=116
int Width=338
int Height=172
int TabOrder=110
boolean Visible=false
boolean BringToTop=true
string DataObject="report_carta_anticipo_prorroga"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type em_banco from u_em_campo within w_list_anticipos_prorroga
event getfocus pbm_ensetfocus
event modificado pbm_custom02
int X=96
int Y=192
int Width=283
int TabOrder=10
boolean BringToTop=true
string Mask="!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

end event

event modificado;call super::modificado;st_nombre_banco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombre_banco.text)="" THEN 
 IF Trim(st_nombre_banco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF
end event

type em_fecha from editmask within w_list_anticipos_prorroga
int X=1838
int Y=180
int Width=329
int Height=88
int TabOrder=61
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd-mm-yy"
MaskDataType MaskDataType=DateTimeMask!
string DisplayData=""
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

