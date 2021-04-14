$PBExportHeader$wtc_mant_albaranes_facturados.srw
forward
global type wtc_mant_albaranes_facturados from wt_padre_vacio
end type
type em_anyo from u_em_campo within wtc_mant_albaranes_facturados
end type
type em_albaran from u_em_campo within wtc_mant_albaranes_facturados
end type
type st_1 from statictext within wtc_mant_albaranes_facturados
end type
type st_2 from statictext within wtc_mant_albaranes_facturados
end type
type dw_1 from u_dw within wtc_mant_albaranes_facturados
end type
type pb_guardar from picturebutton within wtc_mant_albaranes_facturados
end type
type gb_1 from groupbox within wtc_mant_albaranes_facturados
end type
end forward

global type wtc_mant_albaranes_facturados from wt_padre_vacio
integer width = 2181
integer height = 2208
em_anyo em_anyo
em_albaran em_albaran
st_1 st_1
st_2 st_2
dw_1 dw_1
pb_guardar pb_guardar
gb_1 gb_1
end type
global wtc_mant_albaranes_facturados wtc_mant_albaranes_facturados

forward prototypes
public function integer f_consultar (integer anyo, decimal albaran)
public function integer f_guardar ()
end prototypes

public function integer f_consultar (integer anyo, decimal albaran);//Hace que el datawindow recupere los datos del albarán consultado

Int resultado = 0
Dec peso_bruto_venalb, peso_neto_venalb
Int bultos, fila
String observaciones_venalb, forma_envio_venalb, conductor, precinto, matricula, transporte, dni, contenedor, venformaenvio_descripcion

dw_1.reset()

SELECT COUNT(*)
INTO :resultado
FROM venlifac 
WHERE empresa = :codigo_empresa 
AND anyo_albaran = :anyo 
AND albaran = :albaran;

if resultado > 0 then
	SELECT TOP 1 peso_bruto_venalb, peso_neto_venalb, bultos, observaciones_venalb, forma_envio_venalb, conductor, precinto, matricula, transportista, dni, contenedor  
	INTO :peso_bruto_venalb, :peso_neto_venalb, :bultos, :observaciones_venalb, :forma_envio_venalb, :conductor, :precinto, :matricula, :transporte, :dni, :contenedor    
	FROM venlifac 
	WHERE empresa = :codigo_empresa 
	AND anyo_albaran = :anyo 
	AND albaran = :albaran;
	
	fila = dw_1.insertrow(0)
	dw_1.accepttext()
	
	dw_1.object.peso_bruto[fila] = peso_bruto_venalb
	dw_1.object.peso_neto[fila] = peso_neto_venalb
	dw_1.object.bultos[fila] = bultos
	dw_1.object.forma_envio[fila] = forma_envio_venalb
	dw_1.object.matricula[fila] = matricula
	dw_1.object.precinto[fila] = precinto
	dw_1.object.conductor[fila] = conductor
	dw_1.object.observaciones[fila] = observaciones_venalb
	dw_1.object.transporte[fila] = transporte
	dw_1.object.dni[fila] = dni
	dw_1.object.contenedor[fila] = contenedor
	
	dw_1.object.ventransportista_nombre[fila] = f_nombre_ventransportista(codigo_empresa, transporte)
	
	SELECT descripcion INTO :venformaenvio_descripcion 
	FROM venformaenvio
	WHERE empresa = :codigo_empresa 
	AND codigo = :forma_envio_venalb;
	
	dw_1.object.venformaenvio_descripcion[fila] = venformaenvio_descripcion
	
	dw_1.setfocus()
end if

return resultado


end function

public function integer f_guardar ();//Actualiza las lineas de albarán guardadas en las lineas de factura

Int anyo, fila 
Dec albaran
Dec peso_bruto_venalb, peso_neto_venalb
Int bultos
String observaciones_venalb, forma_envio_venalb, conductor, precinto, matricula, transporte, dni, contenedor
dec factura, anyo_fac


dw_1.accepttext()

if dw_1.rowcount() = 1 then
	
	anyo=integer(em_anyo.text)
	albaran=Dec(em_albaran.text)
	fila = 1
	
	peso_bruto_venalb = dw_1.object.peso_bruto[fila]
	peso_neto_venalb = dw_1.object.peso_neto[fila]
	bultos = dw_1.object.bultos[fila]
	forma_envio_venalb = dw_1.object.forma_envio[fila]
	matricula = dw_1.object.matricula[fila]
	precinto = dw_1.object.precinto[fila]
	conductor = dw_1.object.conductor[fila]
	observaciones_venalb = dw_1.object.observaciones[fila]
	transporte = dw_1.object.transporte[fila]
	dni = dw_1.object.dni[fila]
	contenedor = dw_1.object.contenedor[fila]
	
	
	UPDATE venlifac
	SET peso_bruto_venalb = :peso_bruto_venalb, peso_neto_venalb = :peso_neto_venalb, bultos = :bultos, observaciones_venalb = :observaciones_venalb, forma_envio_venalb = :forma_envio_venalb, 
	conductor = :conductor, precinto = :precinto, matricula = :matricula, transportista = :transporte, dni = :dni, contenedor = :contenedor
	WHERE empresa = :codigo_empresa
	AND anyo_albaran = :anyo
	AND albaran = :albaran using sqlca;
	
	
	
	if sqlca.sqlcode = 0 then
		commit using sqlca;
		return 1 //Si éxito al guardar
	else 
		rollback using sqlca;
		return 0
	end if


else
	return 0
end if


end function

on wtc_mant_albaranes_facturados.create
int iCurrent
call super::create
this.em_anyo=create em_anyo
this.em_albaran=create em_albaran
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.pb_guardar=create pb_guardar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_anyo
this.Control[iCurrent+2]=this.em_albaran
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.pb_guardar
this.Control[iCurrent+7]=this.gb_1
end on

on wtc_mant_albaranes_facturados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_anyo)
destroy(this.em_albaran)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.pb_guardar)
destroy(this.gb_1)
end on

event open;call super::open;em_anyo.text = String(year(Today()))
end event

type pb_salir from wt_padre_vacio`pb_salir within wtc_mant_albaranes_facturados
integer x = 1938
integer y = 184
integer taborder = 0
end type

type st_titulo from wt_padre_vacio`st_titulo within wtc_mant_albaranes_facturados
integer width = 1490
end type

type p_logo from wt_padre_vacio`p_logo within wtc_mant_albaranes_facturados
integer x = 1582
integer y = 16
end type

type em_anyo from u_em_campo within wtc_mant_albaranes_facturados
integer x = 370
integer y = 216
integer width = 192
integer height = 80
integer taborder = 10
boolean bringtotop = true
end type

type em_albaran from u_em_campo within wtc_mant_albaranes_facturados
integer x = 910
integer y = 216
integer width = 283
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "#######"
string displaydata = "~b"
end type

event modificado;int anyo
dec albaran

anyo=integer(em_anyo.text)
albaran=Dec(em_albaran.text)

f_consultar(anyo, albaran)

call super::modificado
end event

type st_1 from statictext within wtc_mant_albaranes_facturados
integer x = 87
integer y = 224
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 24011603
long backcolor = 553648127
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within wtc_mant_albaranes_facturados
integer x = 617
integer y = 224
integer width = 251
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 24011603
long backcolor = 553648127
string text = "Albarán:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from u_dw within wtc_mant_albaranes_facturados
integer x = 59
integer y = 360
integer width = 2016
integer height = 1620
boolean bringtotop = true
string dataobject = "dwtc_mant_albaranes_facturados"
end type

event itemchanged;call super::itemchanged;String resultado 
if row > 0 then
	if dwo.name = "forma_envio" then
		SELECT descripcion 
		INTO :resultado
		FROM venformaenvio
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.venformaenvio_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.venformaenvio_descripcion[Row] 		= ''
			return 2
		end if
	elseif dwo.name = "transporte" then
		SELECT nombre 
		INTO :resultado
		FROM ventransportista
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.ventransportista_nombre[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.ventransportista_nombre[Row] 		= ''
			return 2
		end if
	end if
end if
end event

event usr_dwnkey;call super::usr_dwnkey;string campo
String modelo, cliente, propuesta, pieza, version_color, version_actual
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
Int i

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "forma_envio"
			busqueda.titulo_ventana = "Búsqueda de Forma de envío"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM venformaenvio "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Forma de Envío"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.forma_envio[this.GetRow()] 					= resultado.valores[1]		
				this.object.venformaenvio_descripcion[this.GetRow()] = resultado.valores[2]		
			end if
			
		CASE "transporte"
			busqueda.titulo_ventana = "Búsqueda de Transportista"
			busqueda.consulta  = "SELECT CODIGO, nombre FROM ventransportista WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY nombre"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Transportista"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.transporte[this.GetRow()] 				= resultado.valores[1]			
				this.object.ventransportista_nombre[this.GetRow()] = resultado.valores[2]			
			end if					
	END CHOOSE
end if	
end event

type pb_guardar from picturebutton within wtc_mant_albaranes_facturados
integer x = 1577
integer y = 180
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Save_24x24.png"
end type

event clicked;if f_guardar() <> 1 then
	MessageBox("Error", "No se ha podido realizar el guardado")
end if
end event

type gb_1 from groupbox within wtc_mant_albaranes_facturados
integer x = 59
integer y = 104
integer width = 1189
integer height = 236
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 24011603
long backcolor = 553648127
string text = "Albarán"
end type

