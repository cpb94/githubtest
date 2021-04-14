$PBExportHeader$w_repaso_mercaderías.srw
forward
global type w_repaso_mercaderías from window
end type
type cb_1 from commandbutton within w_repaso_mercaderías
end type
end forward

global type w_repaso_mercaderías from window
integer x = 654
integer y = 268
integer width = 2167
integer height = 380
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_1 cb_1
end type
global w_repaso_mercaderías w_repaso_mercaderías

forward prototypes
public subroutine f_repasar_venlifac ()
end prototypes

public subroutine f_repasar_venlifac ();datastore dd 
String sel
Dec cont,i,v_factura,v_linea,v_anyo
String v_articulo,v_calidad,v_tipopallet,v_caja,v_tipolinea
Integer v_tono,v_calibre,traspasos,bien

bien = 1
sel = "SELECT modelo,calidad,tono,calibre,tipo_pallet,caja,anyo,factura,linea_factura,tipo_linea "+&
	   " FROM venlifac " +&
		" WHERE empresa = '1'"

//dd = f_cargar_cursor (sel)
f_cargar_cursor_nuevo(sel, dd)

cont = dd.rowcount()

for i=1 to cont
	v_articulo   = dd.GetItemString (i,"modelo")
	v_calidad    = dd.GetItemString (i,"calidad")
	v_tono       = dd.GetItemNumber (i,"tono")
	v_calibre    = dd.GetItemNumber (i,"calibre")
	v_tipopallet = dd.GetItemString (i,"tipo_pallet")
	v_caja       = dd.GetItemString (i,"caja")
	//v_tipolinea  = dd.GetItemString (i,"tipo_linea")
	v_anyo       = dd.GetItemNumber (i,"anyo")
	v_factura    = dd.GetItemNumber (i,"factura")
	v_linea      = dd.GetItemNumber (i,"linea_factura")	
	SELECT COUNT(*)
		INTO :traspasos
		FROM almmovhis
		WHERE articulo = :v_articulo 
			AND calidad = :v_calidad
			AND tono    = :v_tono
			AND calibre = :v_calibre
			AND tipo_pallet = :v_tipopallet
			AND caja    = :v_caja
			AND tipomov = "103"
			AND almacen = "2"
			AND empresa = "1"
	USING sqlca;
	If sqlca.sqlcode<>0 then
		f_mensaje("error","select into traspasos")
		bien=0
	end if
	if traspasos > 0 then
		// ha habido un traspaso al almacén 2
		f_mensaje("Articulo",v_articulo + "calidad "+ v_calidad+" to "+String(v_tono)+&
			" cal "+String(v_calibre)+" tp " +v_tipopallet + " tc " + v_caja)
		f_mensaje("Factura","anyo "+String(v_anyo) + "fra. "+ String(v_factura)+&
			" linea "+String(v_linea))

		UPDATE   venlifac
			SET   tipolinea = "7"
			WHERE empresa = "1"
				AND anyo    = :v_anyo
				AND factura = :v_factura
				AND linea_factura = :v_linea
		USING sqlca;
		
		If sqlca.sqlcode<>0 then
			f_mensaje("error","update venlifac")
			bien=0
		end if
	end if
	
	f_mensaje_proceso ("Actualizando facturas",i,cont)			
		
next

if bien = 1 then
	COMMIT;
else
	ROLLBACK;
	f_mensaje("error","no se actualiza la operacion")
end if

destroy dd
//Return 0
end subroutine

on w_repaso_mercaderías.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_repaso_mercaderías.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_repaso_mercaderías
integer x = 1024
integer y = 68
integer width = 663
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "corrección tipo linea"
end type

event clicked;
f_repasar_venlifac()
end event

