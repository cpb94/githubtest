$PBExportHeader$w_list_anticipos2.srw
forward
global type w_list_anticipos2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_list_anticipos2
end type
type em_anyo from editmask within w_list_anticipos2
end type
type st_8 from statictext within w_list_anticipos2
end type
type em_vencimiento from u_em_campo within w_list_anticipos2
end type
type em_plazo_real from u_em_campo within w_list_anticipos2
end type
type st_9 from statictext within w_list_anticipos2
end type
type st_nombre_banco from statictext within w_list_anticipos2
end type
type dw_1 from datawindow within w_list_anticipos2
end type
type cb_consultar from commandbutton within w_list_anticipos2
end type
type cb_marcar from commandbutton within w_list_anticipos2
end type
type cb_desmarcar from commandbutton within w_list_anticipos2
end type
type gb_5 from groupbox within w_list_anticipos2
end type
type gb_3 from groupbox within w_list_anticipos2
end type
type gb_2 from groupbox within w_list_anticipos2
end type
type gb_1 from groupbox within w_list_anticipos2
end type
type pb_cartas from picturebutton within w_list_anticipos2
end type
type st_5 from statictext within w_list_anticipos2
end type
type dw_listado from datawindow within w_list_anticipos2
end type
type rb_1 from radiobutton within w_list_anticipos2
end type
type rb_2 from radiobutton within w_list_anticipos2
end type
type em_banco from u_em_campo within w_list_anticipos2
end type
end forward

global type w_list_anticipos2 from w_int_con_empresa
int Width=2908
int Height=1597
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
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
pb_cartas pb_cartas
st_5 st_5
dw_listado dw_listado
rb_1 rb_1
rb_2 rb_2
em_banco em_banco
end type
global w_list_anticipos2 w_list_anticipos2

type variables
string filtro

editmask isle_campo

integer var_ejercicio
string es_nacional
boolean inst_nuevo
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Impresión de Anticipos"
This.title=istr_parametros.s_titulo_ventana


dw_1.settransobject(sqlca)
dw_listado.settransobject(sqlca)

em_anyo.text = string(year(today()))

pb_cartas.enabled = false

rb_1.checked = true
rb_2.checked = false






end event

on w_list_anticipos2.create
int iCurrent
call w_int_con_empresa::create
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
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.pb_cartas=create pb_cartas
this.st_5=create st_5
this.dw_listado=create dw_listado
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_banco=create em_banco
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=pb_1
this.Control[iCurrent+2]=em_anyo
this.Control[iCurrent+3]=st_8
this.Control[iCurrent+4]=em_vencimiento
this.Control[iCurrent+5]=em_plazo_real
this.Control[iCurrent+6]=st_9
this.Control[iCurrent+7]=st_nombre_banco
this.Control[iCurrent+8]=dw_1
this.Control[iCurrent+9]=cb_consultar
this.Control[iCurrent+10]=cb_marcar
this.Control[iCurrent+11]=cb_desmarcar
this.Control[iCurrent+12]=gb_5
this.Control[iCurrent+13]=gb_3
this.Control[iCurrent+14]=gb_2
this.Control[iCurrent+15]=gb_1
this.Control[iCurrent+16]=pb_cartas
this.Control[iCurrent+17]=st_5
this.Control[iCurrent+18]=dw_listado
this.Control[iCurrent+19]=rb_1
this.Control[iCurrent+20]=rb_2
this.Control[iCurrent+21]=em_banco
end on

on w_list_anticipos2.destroy
call w_int_con_empresa::destroy
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
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.pb_cartas)
destroy(this.st_5)
destroy(this.dw_listado)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_banco)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_list_anticipos2
int X=2186
int Y=21
int Width=485
int TabOrder=0
end type

type st_empresa from w_int_con_empresa`st_empresa within w_list_anticipos2
int X=10
int Y=5
int Width=2428
int Height=89
boolean BringToTop=true
end type

type pb_1 from upb_salir within w_list_anticipos2
int X=2707
int Y=17
int Width=147
int Height=137
int TabOrder=0
end type

type em_anyo from editmask within w_list_anticipos2
int X=1564
int Y=181
int Width=193
int Height=89
int TabOrder=50
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

type st_8 from statictext within w_list_anticipos2
int X=2958
int Y=325
int Width=417
int Height=77
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

type em_vencimiento from u_em_campo within w_list_anticipos2
int X=3379
int Y=333
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

type em_plazo_real from u_em_campo within w_list_anticipos2
int X=3443
int Y=425
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

type st_9 from statictext within w_list_anticipos2
int X=2935
int Y=425
int Width=380
int Height=77
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

type st_nombre_banco from statictext within w_list_anticipos2
int X=453
int Y=201
int Width=915
int Height=77
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

type dw_1 from datawindow within w_list_anticipos2
int X=42
int Y=349
int Width=2670
int Height=861
int TabOrder=120
boolean BringToTop=true
string DataObject="dw_list_anticipos"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_consultar from commandbutton within w_list_anticipos2
int X=2003
int Y=173
int Width=330
int Height=109
int TabOrder=60
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
	for i = 1 to registros
		situ = dw_1.getitemnumber(i,"situacion")		
		if situ = 0 then 
			dw_1.setitem(i,"punt","S")	
		end if		
	next

else
	pb_cartas.enabled = false
	
	
end if


end event

type cb_marcar from commandbutton within w_list_anticipos2
int X=42
int Y=1217
int Width=366
int Height=77
int TabOrder=90
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

type cb_desmarcar from commandbutton within w_list_anticipos2
int X=412
int Y=1217
int Width=366
int Height=77
int TabOrder=70
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

type gb_5 from groupbox within w_list_anticipos2
int X=1061
int Y=1229
int Width=581
int Height=217
int TabOrder=100
string Text="Modelo carta"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_list_anticipos2
int X=1921
int Y=109
int Width=494
int Height=201
int TabOrder=40
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_list_anticipos2
int X=1418
int Y=105
int Width=481
int Height=205
int TabOrder=30
string Text="Año Anticipo"
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_list_anticipos2
int X=60
int Y=105
int Width=1354
int Height=205
int TabOrder=20
string Text="Banco Anticipo"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_cartas from picturebutton within w_list_anticipos2
event clicked pbm_bnclicked
int X=2259
int Y=1269
int Width=174
int Height=153
int TabOrder=80
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


// Según el tipo de carta elegido
if rb_1.checked and not rb_2.checked then dw_listado.dataobject = "report_carta_anticipo2"
if not rb_1.checked and rb_2.checked then dw_listado.dataobject = "report_carta_anticipo_bancaja"
dw_listado.settransobject(sqlca)

for i = 1 to dw_1.rowcount()
	punte = dw_1.getitemstring(i,"punt")
	if punte = "S" then
		int el_anyo,la_prorroga,el_contador
		string el_banco
		
		el_anyo = dw_1.getitemnumber(i,"anyo")
		el_banco = dw_1.getitemstring(i,"bancofinan")
		la_prorroga = dw_1.getitemnumber(i,"num_prorroga")
		el_contador = dw_1.getitemnumber(i,"contador")
		
		// Provisionalmente la situación va a ser -1		
		// cambiamos la situación del anticipo. situación -1 
		update carfinan
		set situacion = -1
		where (empresa = :codigo_empresa) and
				(bancofinan = :el_banco) and
				(contador = :el_contador) and
				(num_prorroga = :la_prorroga) and
				(anyo = :el_anyo);
		
		
	end if
	
	
next
COMMIT;

dw_listado.retrieve(codigo_empresa,el_anyo,el_banco,la_prorroga,el_contador,cabecera)		
f_imprimir_datawindow(dw_listado)


int opcion
opcion = messagebox("Atención","¿ La impresión es correcta ?",question!,yesno!,1)
if opcion = 1 then
	for i = 1 to dw_1.rowcount()
		punte = dw_1.getitemstring(i,"punt")
		if punte = "S" then		
			
			el_anyo = dw_1.getitemnumber(i,"anyo")
			el_banco = dw_1.getitemstring(i,"bancofinan")
			la_prorroga = dw_1.getitemnumber(i,"num_prorroga")
			el_contador = dw_1.getitemnumber(i,"contador")
			
						
			// cambiamos la situación del anticipo. situación 1 
			update carfinan
			set situacion = 1
			where (empresa = :codigo_empresa) and
					(bancofinan = :el_banco) and
					(contador = :el_contador) and
					(num_prorroga = :la_prorroga) and
					(anyo = :el_anyo);
		
		
		end if
	next
	
else
	
	for i = 1 to dw_1.rowcount()
		punte = dw_1.getitemstring(i,"punt")
		if punte = "S" then		
			
			el_anyo = dw_1.getitemnumber(i,"anyo")
			el_banco = dw_1.getitemstring(i,"bancofinan")
			la_prorroga = dw_1.getitemnumber(i,"num_prorroga")
			el_contador = dw_1.getitemnumber(i,"contador")
			
						
			// vuelve a ser la situación 0.  
			update carfinan
			set situacion = 0
			where (empresa = :codigo_empresa) and
					(bancofinan = :el_banco) and
					(contador = :el_contador) and
					(num_prorroga = :la_prorroga) and
					(anyo = :el_anyo);
	
	
		end if

	next

end if


end event

type st_5 from statictext within w_list_anticipos2
int X=1774
int Y=1309
int Width=444
int Height=77
boolean Enabled=false
string Text="Carta al Banco"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_listado from datawindow within w_list_anticipos2
int X=755
int Y=117
int Width=339
int Height=173
int TabOrder=110
boolean Visible=false
boolean BringToTop=true
string DataObject="report_carta_anticipo_bancaja"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type rb_1 from radiobutton within w_list_anticipos2
int X=1143
int Y=1289
int Width=293
int Height=73
boolean BringToTop=true
string Text="Normal"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_list_anticipos2
int X=1143
int Y=1353
int Width=430
int Height=69
boolean BringToTop=true
string Text="Declaración"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_banco from u_em_campo within w_list_anticipos2
event getfocus pbm_ensetfocus
event modificado pbm_custom02
int X=142
int Y=193
int Width=284
int TabOrder=10
boolean BringToTop=true
string Mask="!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
long BackColor=16777215
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

