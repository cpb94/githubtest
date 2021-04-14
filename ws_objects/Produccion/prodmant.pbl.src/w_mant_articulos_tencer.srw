$PBExportHeader$w_mant_articulos_tencer.srw
forward
global type w_mant_articulos_tencer from wc_mantenimientos_tab
end type
type dw_calidades from datawindow within pagina_1
end type
type dw_cajas from datawindow within pagina_1
end type
type dw_pallets from datawindow within pagina_1
end type
type dw_etiquetas from u_dw within pagina_1
end type
type pb_anyadir from picturebutton within pagina_1
end type
type pb_eliminar from picturebutton within pagina_1
end type
type dw_mp from u_dw within pagina_1
end type
type pb_2 from picturebutton within pagina_1
end type
type pb_3 from picturebutton within pagina_1
end type
type dw_promocion from u_dw within pagina_1
end type
type pb_4 from picturebutton within pagina_1
end type
type pb_5 from picturebutton within pagina_1
end type
type st_13 from statictext within pagina_2
end type
type st_14 from statictext within pagina_2
end type
type dw_tarifas from datawindow within pagina_2
end type
type cb_3 from commandbutton within pagina_2
end type
type r_4 from rectangle within pagina_2
end type
type dw_codestadistico from datawindow within pagina_2
end type
type st_11 from statictext within pagina_3
end type
type st_12 from statictext within pagina_3
end type
type gb_3 from groupbox within pagina_3
end type
type cb_insertar_idiomas from commandbutton within pagina_3
end type
type cb_borrar_idiomas from commandbutton within pagina_3
end type
type st_17 from statictext within pagina_5
end type
type st_16 from statictext within pagina_5
end type
type dw_listado_ficha from datawindow within pagina_5
end type
type r_3 from rectangle within pagina_5
end type
type rr_1 from roundrectangle within pagina_5
end type
type cb_1 from commandbutton within pagina_5
end type
type r_5 from rectangle within pagina_5
end type
type pb_1 from upb_imprimir within pagina_5
end type
type r_6 from rectangle within pagina_5
end type
type cb_traspaso from commandbutton within pagina_5
end type
type cb_copiar_parametros from commandbutton within pagina_5
end type
type pb_anyade_grupo from picturebutton within pagina_5
end type
type pb_borra_grupo from picturebutton within pagina_5
end type
type dw_grupo_combi from datawindow within pagina_5
end type
type p_imagen from picture within pagina_7
end type
type dw_imagen from u_dw_imagen within pagina_7
end type
type pb_archivos_modelo from picturebutton within pagina_7
end type
type st_7 from statictext within pagina_7
end type
type dw_3 from datawindow within pagina_8
end type
type dw_2 from datawindow within pagina_8
end type
type pb_añadir from picturebutton within pagina_8
end type
type pb_borrar from picturebutton within pagina_8
end type
type pb_calculadora2 from picturebutton within w_mant_articulos_tencer
end type
type cb_generar from commandbutton within w_mant_articulos_tencer
end type
type cb_2 from commandbutton within w_mant_articulos_tencer
end type
type r_1 from rectangle within w_mant_articulos_tencer
end type
type st_aviso from statictext within w_mant_articulos_tencer
end type
type cb_4 from commandbutton within w_mant_articulos_tencer
end type
type cb_5 from commandbutton within w_mant_articulos_tencer
end type
type cb_6 from commandbutton within w_mant_articulos_tencer
end type
end forward

global type w_mant_articulos_tencer from wc_mantenimientos_tab
integer x = 5
integer y = 4
integer width = 5879
integer height = 3360
pb_calculadora2 pb_calculadora2
cb_generar cb_generar
cb_2 cb_2
r_1 r_1
st_aviso st_aviso
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
end type
global w_mant_articulos_tencer w_mant_articulos_tencer

type variables
string ant_familia,ant_formato
boolean ver_notas = false
boolean ver_costes = true
string version_actual
string nuevo_idioma

end variables

forward prototypes
public subroutine f_grabar_calidades (string arg_formato, string arg_articulo)
public function string f_arbol (string arg_articulo, string arg_version)
public function integer fr_cambio_parametros_base (str_aux_parametros_base parametros, string articulo)
public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key)
end prototypes

public subroutine f_grabar_calidades (string arg_formato, string arg_articulo);// Graba el mapa de calidades por formato en el mapa de calidades por articulo
integer   li_opcion,bien,registros
long      existe 
String    calidad
datetime  fecha_alta
string    fin,sel
integer   cont
datastore dw_proceso

sel = "SELECT calidad "+&
      "FROM calformato "+&
   	"WHERE empresa = '"+codigo_empresa+"' "+&
      "AND   formato = '"+arg_formato+"' "
		
dw_proceso = f_cargar_cursor(sel)		

registros = dw_proceso.rowcount()

IF registros > 0 Then
	fecha_alta = datetime(today())
	FOR cont = 1 To registros
		calidad = dw_proceso.object.calidad[cont]
		
		SELECT count(*)
		INTO   :existe
		FROM   almartcal  
		WHERE (almartcal.empresa  = :codigo_empresa )
		AND  	(almartcal.articulo = :arg_articulo )
		AND  	(almartcal.calidad  = :calidad );
		
		if isnull(existe) then existe = 0 
		if existe > 0 THEN
			li_opcion = MessageBox("Existen Calidades Por Articulo", &
			 							  "Refrescar la Calidad Según Formato", &
										  Question!, YesNo!, 2)
			IF li_opcion = 1 THEN
				DELETE FROM almartcal  
				WHERE (almartcal.empresa  = :codigo_empresa) 
				AND  	(almartcal.articulo = :arg_articulo)
				AND  	(almartcal.calidad  = :calidad ) 
				USING SQLCA;
				IF SQLCA.SQLCode <> 0 THEN bien=1
			END IF
		ELSE
			li_opcion = 1
		END IF
		If li_opcion = 1 THEN
			INSERT INTO almartcal  
				(empresa,			articulo,
				 calidad,			precio,
				 fecha_alta)  
			VALUES 
				(:codigo_empresa,	:arg_articulo,
				 :calidad,			0,
				 :fecha_alta);
				 
			IF SQLCA.SQLCode <> 0 THEN  bien=1
		END IF                                     
	NEXT

	IF bien = 1 THEN
		rollback;
		MessageBox("Problemas en la transaccion", &
					  "No se puede Grabar El mapa de Calidades", &
					  Exclamation!,Ok!,2)
	ELSE
		commit;
	END IF
END IF

destroy dw_proceso
end subroutine

public function string f_arbol (string arg_articulo, string arg_version);datastore ds_arbol
long i, total_reg
string sel, base

//sel = " select codigo, version, base "+&
//		" from art_estructura "+&
//		" where codigo = '"+arg_articulo+"'"+&
//		" and version = '"+arg_version+"'"

sel = " select codigo, version, base "+&
		" from art_estructura "+&
		" where codigo = '"+arg_articulo+"'"

f_cargar_cursor_nuevo (sel, ds_arbol)	
total_reg = ds_arbol.RowCount()
i = 1

do while (i <= total_reg)
	if isnull(ds_arbol.object.base[i]) then 
		base = '' 
	else 
		base = ds_arbol.object.base[i]
	end if
	
	if base <> ''  then 
		f_arbol (ds_arbol.object.base[i], ds_arbol.object.version[i])
	end if

	messagebox("",STRING(ds_arbol.object.codigo[i]))
	i++
loop
destroy ds_arbol

return 'a'
end function

public function integer fr_cambio_parametros_base (str_aux_parametros_base parametros, string articulo);String sel, siguiente, uso
Datastore escandallo
Long i
Int resultado = 1

SELECT articulo_ant 
INTO :siguiente 
FROM art_escandallo 
WHERE empresa = :codigo_empresa AND articulo = :articulo;

sel =  "SELECT articulo_ant "+&
		"FROM art_escandallo "+&
		"WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+articulo+"' "
f_cargar_cursor_trans (SQLCA,  sel,  escandallo)

i = 1
Do while i <= escandallo.RowCount()
	siguiente = trim(escandallo.object.articulo_ant[i])
	if isnull(siguiente) then siguiente = ""
	if siguiente <> "" and siguiente <> "0" then
		uso = ""
		SELECT uso INTO :uso FROM articulos WHERE empresa = :codigo_empresa AND codigo = :siguiente;
		if uso <> "1" then		
			resultado = fr_cambio_parametros_base(parametros, siguiente)
			if resultado = 1 then
				UPDATE articulos 
				SET molde = :parametros.molde, plato_sup = :parametros.plato_sup, plato_inf = :parametros.plato_inf, costilla = :parametros.costilla,
					familia = :parametros.familia, relieve = :parametros.relieve, cliente = :parametros.cliente, //descripcion = :parametros.descripcion, 
					espesor =  :parametros.espesor, pesopieza = :parametros.pesopieza, marco = :parametros.marco 
				WHERE empresa = :codigo_empresa AND codigo = :siguiente;
				IF SQLCA.SQLCode <> 0 THEN         
					MessageBox("SQL error ", SQLCA.SQLErrText)
					resultado = 0
				END IF
			end if 
		end if // FIN IF BASE
	end if //FIN IF siguiente = ""
	i++
Loop

Destroy escandallo
return resultado
end function

public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key);


end subroutine

on w_mant_articulos_tencer.create
int iCurrent
call super::create
this.pb_calculadora2=create pb_calculadora2
this.cb_generar=create cb_generar
this.cb_2=create cb_2
this.r_1=create r_1
this.st_aviso=create st_aviso
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora2
this.Control[iCurrent+2]=this.cb_generar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.r_1
this.Control[iCurrent+5]=this.st_aviso
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.cb_6
end on

on w_mant_articulos_tencer.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora2)
destroy(this.cb_generar)
destroy(this.cb_2)
destroy(this.r_1)
destroy(this.st_aviso)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
end on

event open;call super::open;integer permiso
/*
permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora2.visible = false;		
		apartados.pagina_5.cb_copiar_parametros.visible = false
end choose
*/



titulo = "Mantenimiento de Articulos"
This.title = titulo

dw_pag1.SetTransObject(SQLCA)
dw_pag2.SetTransObject(SQLCA)
dw_pag3.SetTransObject(SQLCA)
dw_pag5.SetTransObject(SQLCA)
dw_pag6.SetTransObject(SQLCA)
dw_pag7.SetTransObject(SQLCA)
dw_pag8.SetTransObject(SQLCA)


apartados.pagina_1.dw_calidades.SetTransObject(SQLCA)
apartados.pagina_1.dw_cajas.SetTransObject(SQLCA)
apartados.pagina_1.dw_pallets.SetTransObject(SQLCA)
apartados.pagina_2.dw_tarifas.SetTransObject(SQLCA)
apartados.pagina_2.dw_codestadistico.SetTransObject(SQLCA)
apartados.pagina_5.dw_listado_ficha.SetTransObject(SQLCA)
apartados.pagina_5.dw_grupo_combi.SetTransObject(SQLCA)
apartados.pagina_1.dw_etiquetas.SetTransObject(SQLCA)
apartados.pagina_1.dw_mp.SetTransObject(SQLCA)
apartados.pagina_1.dw_promocion.SetTransObject(SQLCA)
apartados.pagina_8.dw_2.SetTransObject(SQLCA)
apartados.pagina_8.dw_3.SetTransObject(SQLCA)

//dw_pag1.sharedata(dw_pag2)
//dw_pag1.sharedata(dw_pag5)
//dw_pag1.sharedata(dw_pag7)


// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos > 1 THEN
	sle_valor.text = istr_parametros.s_argumentos[2]
	version_actual = istr_parametros.s_argumentos[3]
	if isnull(version_actual) then version_actual = ""
	version_actual = trim(version_actual)
	istr_parametros.i_nargumentos = 0

	this.TriggerEvent("ue_recuperar")

END IF


end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora2.enabled = true
apartados.pagina_3.cb_insertar_idiomas.enabled  = false
apartados.pagina_3.cb_borrar_idiomas.enabled    = false

end event

event ue_actualiza_dw;string observaciones,articulo
long   donde
datetime var_fecha

datawindow DW
int total_imagenes, fila_actual, total_regs
string modelo_origen, pieza_origen, ruta, fichero, arabe
datetime fecha_modificacion
int rtn = 1

articulo      = sle_valor.text

rtn = apartados.pagina_1.dw_etiquetas.update()
if rtn = 1 then
	rtn = apartados.pagina_1.dw_mp.update()
end if
if rtn = 1 then
	rtn = apartados.pagina_1.dw_promocion.update()
end if

rtn = apartados.pagina_5.dw_grupo_combi.update()

if rtn <> 1 then
	rollback;
	rtn = -1
	messagebox("Error", "Error actualizando los grupos combinados del artículo")
end if

apartados.pagina_2.dw_codestadistico.setfilter("")
apartados.pagina_2.dw_codestadistico.filter()
if apartados.pagina_2.dw_codestadistico.update() <> 1 then
	rollback;
	rtn = -1
	messagebox("Error","Error actualizando el código estadístico")
end if


//------------------------------------------------------------------

DW = apartados.pagina_1.dw_pagina1
DW.Accepttext()
fila_actual = DW.GetRow()
arabe = DW.object.articulos_descripcion_arabe[fila_actual]


if rtn  = 1 then
	//insertamos la imagen del modelo

	DW = apartados.pagina_5.dw_pagina5
	total_imagenes = 0
	articulo = String(sle_valor.text)
	modelo_origen = ""//Trim(String(DW.object.modelo_origen[DW.getrow()]))
	pieza_origen = ""//Trim(String(DW.object.pieza_origen[DW.getrow()]))
	if not isnull(articulo) and articulo <> "" and not isnull(modelo_origen) and modelo_origen <> "" then
		SELECT isnull(COUNT(*), 0) 
		INTO :total_imagenes 
		FROM articulo_imagenes_encajado 
		WHERE empresa = :codigo_empresa 
			AND articulo = :articulo
		using sqlca;
		
		if total_imagenes = 0 then
			fecha_modificacion = datetime(today(), now())
			if not isnull(pieza_origen) and pieza_origen <> "" then
				SELECT TOP 1 ruta, fichero 
				INTO :ruta, :fichero 
				FROM modelo_pieza_archivo 
				WHERE empresa = :codigo_empresa 
					AND pieza = :pieza_origen
				USING SQLCA;
			else
				SELECT ruta, fichero 
				INTO :ruta, :fichero 
				FROM modelo_archivo_expo 
				WHERE empresa = :codigo_empresa 
				AND modelo = :modelo_origen 
				AND produccion = 1 
				USING SQLCA;
			end if
			
			select isnull(count(*), 0)
			into :total_regs
			from articulos_imagen_encajado
			where empresa = :codigo_empresa
				and articulo = :articulo 
				and codigo  = '1'
			using sqlca;
			
			if total_regs = 0 then
				INSERT INTO articulos_imagen_encajado (empresa, articulo, codigo, modelo, pieza, ruta, fichero, produccion, fecha_modificacion) 
				VALUES (:codigo_empresa, :articulo, '1', :modelo_origen, :pieza_origen, :ruta, :fichero, 1, :fecha_modificacion)
				USING SQLCA;
				
				IF SQLCA.SQLCODE <> 0 THEN
					rollback using sqlca;
					RTN = -1
					messagebox("Error","Error Grabando articulos_imagen_encajado ")
				END IF
			end if
		end if	
		
	end if
	

	if rtn = 1 and not isnull(arabe) then
		UPDATE articulos 
		SET descripcion_arabe = :arabe
		WHERE empresa = :codigo_empresa 
		AND codigo = :articulo
		USING SQLCA;
		
		IF SQLCA.SQLCODE <> 0 THEN
			RTN = -1
		END IF
		
		apartados.pagina_1.dw_pagina1.object.articulos_descripcion_arabe[apartados.pagina_1.dw_pagina1.getrow()] = arabe
	end if

	if rtn = 1 then
		delete from uti_colisiones
		where empresa = :codigo_empresa 
		and tabla = "articulos"
		and usuario = :nombre_usuario 
		USING SQLCA;
		IF SQLCA.SQLCODE <> 0 THEN
			RTN = -1
		END IF

	end if
end if

if rtn = -1 then 
	rollback using sqlca;
	rtn = -1
	messagebox("Error","Error Grabando .... ")
end if

if rtn = 1 then
	CALL Super::ue_actualiza_dw
end if

end event

event ue_borra_fila;
Datawindow DW
int rtn = 1

dw = apartados.pagina_2.dw_codestadistico

if DW.DeleteRow(1) = 1 then
	rtn = DW.Update() 
end if

if rtn = 1 then
	commit using sqlca;
	pag_act2  = FALSE
	pag_act3  = FALSE
	pag_act4  = FALSE
	pag_act5  = FALSE
	pag_act6  = FALSE
	pag_act7  = FALSE
	CALL Super::ue_borra_fila
	pag_act2  = TRUE
	pag_act3  = TRUE
	pag_act4  = TRUE
	pag_act5  = TRUE
	pag_act6  = TRUE
	pag_act7  = TRUE
else
	rollback using sqlca;
end if
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora2.enabled = false
apartados.pagina_3.cb_insertar_idiomas.enabled  = true
apartados.pagina_3.cb_borrar_idiomas.enabled    = true

end event

event ue_inserta_fila;Dec{3} var_peso
String familia,formato,modelo,tono,calibre
DataWindow DW 

DW = apartados.pagina_2.dw_codestadistico
if DW.RowCount() = 0 then
  	DW.scrolltorow(DW.InsertRow(1))
  	DW.SetColumn(1)
end if

pag_act3  = FALSE
pag_act4  = FALSE
//pag_act5  = FALSE
pag_act6  = FALSE
CALL Super::ue_inserta_fila
pag_act3  = TRUE
pag_act4  = TRUE
//pag_act5  = TRUE
pag_act6  = TRUE
//f_grabar_calidades(formato,sle_valor.text)
if insercion = "S" Then
	// VALORES INICIALES
	dw_pag1.SetItem(1,"empresa",codigo_empresa)
	dw_pag1.SetItem(1,"codigo",sle_valor.text)
	dw_pag1.SetItem(1,"activo","S")
	dw_pag1.SetItem(1,"fecha_alta",today())
	dw_pag1.SetItem(1,"usuario",nombre_usuario)
	dw_pag1.setitem(1,"compras","N") 
	dw_pag1.setitem(1,"unidad","0")
	dw_pag1.setitem(1,"tono","N")
	dw_pag1.setitem(1,"calibre","N")
	dw_pag1.setitem(1,"sector","S")
//	dw_pag1.setitem(1,"control_stock","S")
	dw_pag1.setitem(1,"stock_min",0)
	dw_pag1.setitem(1,"bloqueado","N")
	dw_pag1.setitem(1,"articulos_etiqueta_ccc","N")
	
	// Lo comento porque sino me da un error al que no encuentro explicación
//	apartados.pagina_5.dw_pagina5.setitem(1,"marcado","N")
//	apartados.pagina_5.dw_pagina5.setitem(1,"marco","N")
//	apartados.pagina_5.dw_pagina5.setitem(1,"canto_vivo","N")

	apartados.pagina_1.dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
	apartados.pagina_1.dw_etiquetas.retrieve(codigo_empresa, String(sle_valor.text))
	apartados.pagina_1.dw_mp.retrieve(codigo_empresa, String(sle_valor.text))
	apartados.pagina_1.dw_promocion.retrieve(codigo_empresa, String(sle_valor.text))

	DW.setitem(DW.getrow(),"codigo",sle_valor.text)
	DW.setitem(DW.getrow(),"empresa",codigo_empresa)
end if

end event

event ue_recuperar;integer registros,longitudes
int contador
String  codigo, familia, articulo, ruta_imagen, pasta
long total3
DataWindow DW //Variable datawindow
DataWindowChild ldw_Hijo // David

// Valores Para Funcion de bloqueo
titulo       = This.title
longitud     = len(trim(codigo_empresa))
criterio[1]  = trim(codigo_empresa)+ space(20-longitud)
longitud     = len(trim(sle_valor.text))
criterio[2]  = trim(sle_valor.text)+space(20-longitud)
seleccion[1] = criterio[1]+criterio[2]
seleccion[2] = criterio[1]+criterio[2]
tabla[1]     = "articulos"
tabla[2]     = "almcompuestoart"


///////////////////////////////////////////////////////
// 	CONTROL STOCK, PEDIDO Y PLANIFICADO
///////////////////////////////////////////////////////

boolean hay_pedido, hay_stock, hay_planificado
int total
string texto

hay_pedido = false
hay_stock = false
hay_planificado = false
texto = ""

total = 0
select count(*)
into :total
from venliped
where empresa = :codigo_empresa
and articulo = :sle_valor.text using sqlca;

if total > 0 then	
	hay_pedido = true
	texto = "Hay Pedido. "
end if

total = 0
select SUM(cantidade - cantidads)
into :total
from almacenmovimientos
where empresa = :codigo_empresa
and articulo = :sle_valor.text
group by articulo using sqlca;

if total > 0 then	
	hay_stock = true
	texto = texto + "Hay stock. "
end if

total = 0
select count(*)
into :total
from planificacion
where empresa = :codigo_empresa
and cod_articulo = :sle_valor.text;

if total > 0 then	
	hay_planificado = true
	texto = texto + "Hay Planificado. "
end if

if texto <> '' then
	//messagebox("Aviso", nombre_usuario+": "+texto)
	st_aviso.text = texto
	timer(1)
else	
	st_aviso.text = ""
	st_aviso.visible = false
	timer(0)
end if 

///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////


registros = dw_pag1.Retrieve(codigo_empresa,sle_valor.Text)
dw_pag2.Retrieve(codigo_empresa,sle_valor.Text)
dw_pag3.Retrieve(codigo_empresa,sle_valor.Text)
dw_pag5.Retrieve(codigo_empresa,sle_valor.Text)
dw_pag7.Retrieve(codigo_empresa,sle_valor.Text)
apartados.pagina_8.dw_2.Retrieve(codigo_empresa, sle_valor.Text)

contador = apartados.pagina_8.dw_2.RowCount()
IF contador >= 1 THEN
	pasta = apartados.pagina_8.dw_2.Object.pasta[1]
	apartados.pagina_8.dw_3.reset()
	total3 = apartados.pagina_8.dw_3.Retrieve(codigo_empresa, sle_valor.Text, pasta)
ELSE
	apartados.pagina_8.dw_3.reset()
END IF

apartados.pagina_5.dw_grupo_combi.Retrieve(codigo_empresa,sle_valor.Text)
apartados.pagina_2.dw_tarifas.retrieve(codigo_empresa,sle_valor.text)


if trim(version_actual) = "" then
	version_actual  = f_version_activa_articulo(codigo_empresa,sle_valor.Text)
end if
if version_actual <> "" then	
else
	//David
	apartados.pagina_2.dw_codestadistico.reset()
	// Fin David
end if


//Refrescamos las calidades por articulo.
apartados.pagina_1.dw_calidades.visible = TRUE
apartados.pagina_1.dw_cajas.visible     = TRUE
apartados.pagina_1.dw_pallets.visible   = TRUE

apartados.pagina_1.dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_1.dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_1.dw_pallets.Retrieve(codigo_empresa,sle_valor.text)
nuevo_idioma = "N"

apartados.pagina_1.dw_etiquetas.retrieve(codigo_empresa, String(sle_valor.text))
apartados.pagina_1.dw_mp.retrieve(codigo_empresa, sle_valor.text)
apartados.pagina_1.dw_promocion.retrieve(codigo_empresa, sle_valor.text)

//david
// Hacemos un Retrieve de todos los DataWindowsChild, antes de hacer el del padre,
// para que no nos pida parámetros al ejecutar
apartados.pagina_2.dw_codestadistico.GetChild("G1",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("G2",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("G3",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("G4",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("CT",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("EN",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("OTR",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.GetChild("TM",ldw_Hijo)
ldw_Hijo.SettransObject(SQLCA)
ldw_Hijo.Retrieve(codigo_empresa)

apartados.pagina_2.dw_codestadistico.retrieve(codigo_empresa,sle_valor.text)
// Si el articulo viene generado desde un aprueba de laboratorio, no tendrá la clave
// introducida en la tabla de codigos estadísticos
if apartados.pagina_2.dw_codestadistico.RowCount() = 0 then
	DW = apartados.pagina_2.dw_codestadistico
	if DW.RowCount() = 0 then
		DW.scrolltorow(DW.InsertRow(1))
		DW.SetColumn(1)
	end if
	DW.setitem(DW.getrow(),"codigo",sle_valor.text)
	DW.setitem(DW.getrow(),"empresa",codigo_empresa)
end if
// fin david

// Cargar imagen
string ref_lab, ver_lab, ref_dis, ref_dis2
string v_articulo, imagen, ruta


if dw_pag5.RowCount() > 0 then
	articulo = String(sle_valor.text)
	ruta_imagen = ftc_imagen_articulo_ruta("2", articulo)	
	if not isnull(ruta_imagen) and ruta_imagen <> "" then
		apartados.pagina_7.dw_imagen.Object.datawindow.picture.File =  ruta_imagen
		apartados.pagina_7.dw_imagen.visible = true
		apartados.pagina_7.p_imagen.PictureName = ""
		
	else
		apartados.pagina_7.p_imagen.PictureName = f_cargar_imagen_nuevo(dw_pag5.object.codigo_pantallas[dw_pag5.Getrow()])
		apartados.pagina_7.dw_imagen.visible = false
	end if
end if

/*
if dw_pag1.getrow() > 0 then
	if dw_pag1.object.articulos_promocion[dw_pag1.getrow()] = 'S' then
		apartados.pagina_1.dw_etiquetas.visible = false
		apartados.pagina_1.dw_mp.visible = true
	else
		apartados.pagina_1.dw_etiquetas.visible = true
		apartados.pagina_1.dw_mp.visible = false
	end if
end if
*/
CALL Super::ue_recuperar
	

end event

event ue_valores;call super::ue_valores;// Introducir valores activacion paginas de apartados
// Ejemplo ....: Si se desea una pagina  : pag1= TRUE
//               Si se desean dos paginas: pag2= TRUE
//						               		  : pag3= TRUE

// Introducir valores anulacion proceso de modificado e insercion
// paginas de apartados
// Ejemplo ....: Si se desea una pagina  : pag_act1= TRUE
//               Si se desean dos paginas: pag_act2= TRUE
//						               		  : pag_act3= TRUE

// Introducir las pantallas principales  una por tabla
// paginas de apartados
// Ejemplo ....: Si se desea una pagina  : prin_pag1= TRUE
//               Si se desean dos paginas: prin_pag2= TRUE
//						               		  : prin_pag3= TRUE

pag1      = TRUE
pag_act1  = TRUE
prin_pag1 = TRUE

pag2      = TRUE
pag_act2  = TRUE
prin_pag2 = FALSE

pag3      = TRUE
pag_act3  = TRUE
prin_pag3 = TRUE
/*
pag4      = TRUE
pag_act4  = TRUE
prin_pag4 = TRUE
*/
pag5      = TRUE
pag_act5  = TRUE
prin_pag5 = FALSE
/*
pag6      = TRUE
pag_act6  = TRUE
prin_pag6 = TRUE
*/
pag7      = TRUE
pag_act7  = TRUE
prin_pag7 = FALSE

pag8      = TRUE
pag_act8  = TRUE
prin_pag8 = TRUE
end event

event closequery;call super::closequery;string v_tabla, v_empresa_mas_tabla
v_tabla = "articulos"

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla


delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_empresa_mas_tabla
and titulo = :v_tabla;

if sqlca.sqlcode = -1 then 
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
else
	commit using SQLCA;
end if

end event

event activate;call super::activate;w_mant_articulos_tencer = ventanas_activas[id_ventana_activa].ventana
end event

event ue_pase_valores;call super::ue_pase_valores;
apartados.pagina_1.dw_pagina1.object.cliente[1] = apartados.pagina_2.dw_pagina2.object.cliente[1]
apartados.pagina_1.dw_pagina1.object.articulos_cliente_marca[1] = apartados.pagina_2.dw_pagina2.object.articulos_cliente_marca[1]
apartados.pagina_1.dw_pagina1.object.uso[1] = apartados.pagina_2.dw_pagina2.object.uso[1]
apartados.pagina_1.dw_pagina1.object.familia[1] = apartados.pagina_2.dw_pagina2.object.familia[1]
apartados.pagina_1.dw_pagina1.object.articulos_marcas_codigo[1] = apartados.pagina_2.dw_pagina2.object.articulos_marcas_codigo[1]
apartados.pagina_1.dw_pagina1.object.articulos_submarcas_codigo[1] = apartados.pagina_2.dw_pagina2.object.articulos_submarcas_codigo[1]
apartados.pagina_1.dw_pagina1.object.subfamilia[1] = apartados.pagina_2.dw_pagina2.object.subfamilia[1]
apartados.pagina_1.dw_pagina1.object.articulos_relieve[1] = apartados.pagina_2.dw_pagina2.object.articulos_relieve[1]


apartados.pagina_1.dw_pagina1.object.codigo_pantallas[1]  = apartados.pagina_5.dw_pagina5.object.codigo_pantallas[1]
apartados.pagina_1.dw_pagina1.object.referencia_laboratorio[1]  = apartados.pagina_5.dw_pagina5.object.referencia_laboratorio[1]
apartados.pagina_1.dw_pagina1.object.version_laboratorio[1]  = apartados.pagina_5.dw_pagina5.object.version_laboratorio[1]
apartados.pagina_1.dw_pagina1.object.articulos_modelo_origen[1]  = apartados.pagina_5.dw_pagina5.object.modelo_origen[1]
apartados.pagina_1.dw_pagina1.object.articulos_pieza_origen[1]  = apartados.pagina_5.dw_pagina5.object.pieza_origen[1]
apartados.pagina_1.dw_pagina1.object.articulos_prueba_origen[1]  = apartados.pagina_5.dw_pagina5.object.prueba_origen[1]
apartados.pagina_1.dw_pagina1.object.molde[1]  = apartados.pagina_5.dw_pagina5.object.molde[1]
apartados.pagina_1.dw_pagina1.object.marco[1]  = apartados.pagina_5.dw_pagina5.object.marco[1]
apartados.pagina_1.dw_pagina1.object.plato_sup[1]  = apartados.pagina_5.dw_pagina5.object.plato_sup[1]
apartados.pagina_1.dw_pagina1.object.plato_inf[1]  = apartados.pagina_5.dw_pagina5.object.plato_inf[1]
apartados.pagina_1.dw_pagina1.object.articulos_costilla[1]  = apartados.pagina_5.dw_pagina5.object.articulos_costilla[1]
apartados.pagina_1.dw_pagina1.object.ubi_muestras[1]  = apartados.pagina_5.dw_pagina5.object.ubi_muestras[1]

apartados.pagina_1.dw_pagina1.object.imagen[1]  = apartados.pagina_7.dw_pagina7.object.imagen[1]

apartados.pagina_1.dw_pagina1.object.articulos_porcentaje_dotacion[1] = apartados.pagina_2.dw_pagina2.object.articulos_porcentaje_dotacion[1]
apartados.pagina_1.dw_pagina1.object.articulos_fecha_dotacion[1] = date(apartados.pagina_2.dw_pagina2.object.articulos_fecha_dotacion[1])

apartados.pagina_1.dw_pagina1.object.articulos_colecciones_ccc[1] = apartados.pagina_2.dw_pagina2.object.articulos_colecciones_ccc[1]


end event

event timer;call super::timer;
st_aviso.visible = not(st_aviso.visible) 
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_mant_articulos_tencer
integer x = 5367
integer y = 156
integer width = 402
integer taborder = 50
end type

event cb_salir::clicked;if insercion = "S"  then
	parent.triggerevent(closequery!)
end if

CALL Super::clicked
end event

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_mant_articulos_tencer
boolean visible = false
integer x = 4750
integer y = 136
integer width = 402
integer taborder = 70
boolean enabled = false
end type

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_mant_articulos_tencer
integer x = 4571
integer y = 152
integer width = 402
integer taborder = 100
integer weight = 400
fontcharset fontcharset = ansi!
end type

event cb_insertar::clicked;long fila_actual
String texto
datawindow DW
String articulo, modelo_origen, pieza_origen, ruta, fichero
Long total_imagenes, i
Datetime fecha_modificacion
String arabe,ls_ean13_sga
INT RTN = 1

string empresa, codigo_articulo, descripcion
int n, newrow2
long total2;

string ls_familia,ls_marca,ls_submarca,ls_uso
string ls_familia_descripcion,ls_marca_descripcion,ls_submarca_descripcion,ls_uso_descripcion


if cb_insertar.enabled then	
	DW = apartados.pagina_1.dw_pagina1
	DW.Accepttext()
	
	fila_actual = DW.GetRow()
	arabe = DW.object.articulos_descripcion_arabe[fila_actual]
	DW.object.ean13[fila_actual] = f_calcula_ean13(DW.object.ean13[fila_actual])
	
	if not isnull(DW.object.articulos_descripcion[fila_actual]) then
		texto = trim(String(DW.object.articulos_descripcion[fila_actual]))
		DW.object.articulos_descripcion[fila_actual] = texto
	END IF
	
	//Comprobación campos obligatorios

	ls_uso      = apartados.pagina_2.dw_pagina2.object.uso[1]
	ls_uso_descripcion = f_nombre_almusos(codigo_empresa,ls_uso)
	

	if trim(ls_uso) = "" or trim(ls_uso_descripcion) = "" then
		MessageBox("Error", "Debe introducir el Uso.")
		return
	end if	
	
	if ls_uso = '3' then
		ls_familia  = apartados.pagina_2.dw_pagina2.object.familia[1]
		ls_familia_descripcion = f_nombre_familia(codigo_empresa,ls_familia)
		
		if trim(ls_familia) = "" or trim(ls_familia_descripcion) = "" then
			MessageBox("Error", "Debe introducir la Familia.")
			return
		end if
		
		ls_marca    = apartados.pagina_2.dw_pagina2.object.articulos_marcas_codigo[1]
		ls_marca_descripcion = f_marcas_descripcion(codigo_empresa,ls_familia,ls_marca) 
		
		if trim(ls_marca) = "" or trim(ls_marca_descripcion) = "" then
			MessageBox("Error", "Debe introducir la Marca.")
			return
		end if	
		
		ls_submarca = apartados.pagina_2.dw_pagina2.object.articulos_submarcas_codigo[1]
		ls_submarca_descripcion = f_submarcas_descripcion(codigo_empresa,ls_familia,ls_marca,ls_submarca) 
		
		if trim(ls_submarca) = "" or trim(ls_submarca_descripcion) = "" then
			MessageBox("Error", "Debe introducir la SubMarca.")
			return
		end if	
	end if
	
	if ls_uso = '3' or ls_uso = '1' or ls_uso = '0' then
		ls_ean13_sga = apartados.pagina_1.dw_pagina1.object.ean13_sga[1]
		
		if isnull(ls_ean13_sga) then ls_ean13_sga = ""
		
		if trim(ls_ean13_sga) = "" then
			MessageBox("Error", "Debe calcular el ean13 sga.")
			return			
		end if
	end if
	//DW Auxiliares nuevos
	//Materias primas
	For i = 1 To apartados.pagina_1.dw_mp.rowcount()
		if isnull(apartados.pagina_1.dw_mp.object.articulos_venmprima_mprima[i]) or trim(apartados.pagina_1.dw_mp.object.articulos_venmprima_mprima[i]) = "" then
			MessageBox("Error", "Debe introducir la materias prima.")
			return
		end if
		if isnull(apartados.pagina_1.dw_mp.object.articulos_venmprima_cantidad[i]) or apartados.pagina_1.dw_mp.object.articulos_venmprima_cantidad[i] = 0.00 then
			MessageBox("Error", "Debe introducir la cantidad de las materias primas indicadas")
			return
		end if
	Next
	//Artículos promoción
	For i = 1 To apartados.pagina_1.dw_promocion.rowcount()
		if isnull(apartados.pagina_1.dw_promocion.object.articulo_promocion_articulo[i]) or trim(apartados.pagina_1.dw_promocion.object.articulo_promocion_articulo[i]) = "" then
			MessageBox("Error", "Debe introducir la el artículo de promoción.")
			return
		end if
		if isnull(apartados.pagina_1.dw_promocion.object.articulo_promocion_cantidad[i]) or apartados.pagina_1.dw_promocion.object.articulo_promocion_cantidad[i] = 0 then
			MessageBox("Error", "Debe introducir la cantidad de los artículos de promoción indicados")
			return
		end if
	Next
	
	//Fechas campos dotación
	
	apartados.pagina_2.dw_pagina2.accepttext()
	
	if isnull(apartados.pagina_2.dw_pagina2.object.articulos_fecha_dotacion[1]) and not isnull(apartados.pagina_2.dw_pagina2.object.articulos_porcentaje_dotacion[1]) and apartados.pagina_2.dw_pagina2.object.articulos_porcentaje_dotacion[1] <> 0  then
		
		apartados.pagina_2.dw_pagina2.object.articulos_fecha_dotacion[1] = date(today())
		
	end if
	
	//pagina 8
	apartados.pagina_8.dw_2.accepttext()
	apartados.pagina_8.dw_3.accepttext()
	
	codigo_articulo = apartados.pagina_1.dw_pagina1.Object.codigo[1];
	
	for n = 1 TO apartados.pagina_8.dw_3.rowCount()
			apartados.pagina_8.dw_3.Object.articulos_calibres_empresa[n] = codigo_empresa
			apartados.pagina_8.dw_3.Object.articulos_calibres_codigo_articulo[n] = codigo_articulo
		NEXT
	
	rtn = apartados.pagina_8.dw_2.Update()
	
	IF rtn = 1 THEN
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;
	END IF
	
	rtn = apartados.pagina_8.dw_3.Update()
	
	IF rtn = 1 THEN
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;
	END IF
	
	apartados.pagina_8.dw_2.settransobject(sqlca)
	apartados.pagina_8.dw_3.settransobject(sqlca)
	
end if

CALL Super::clicked

end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_mant_articulos_tencer
integer taborder = 110
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_mant_articulos_tencer
integer x = 18
integer y = 24
integer width = 5810
integer textsize = -12
fontfamily fontfamily = swiss!
long textcolor = 134217857
long backcolor = 553648127
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within w_mant_articulos_tencer
integer y = 160
end type

event sle_valor::busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text = ue_valor
f_buscar_largo(This,param)
This.TriggerEvent("modificado")
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))
end event

event sle_valor::getfocus;call super::getfocus;ue_titulo      = "AYUDA SELECCION DE ARTICULOS"
ue_datawindow  = "dw_ayuda_articulos_almcliartdesc"
ue_filtro      = ""
end event

event sle_valor::modificado;call super::modificado;version_actual = ""
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_mant_articulos_tencer
integer y = 172
integer width = 256
string text = "Artículo:"
end type

type apartados from wc_mantenimientos_tab`apartados within w_mant_articulos_tencer
integer x = 9
integer y = 284
integer width = 5710
integer height = 2820
fontcharset fontcharset = ansi!
end type

on apartados.create
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
call super::destroy
end on

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
event create ( )
event destroy ( )
integer width = 5673
integer height = 2692
string text = "General"
string picturename = "Globals!"
long picturemaskcolor = 553648127
dw_calidades dw_calidades
dw_cajas dw_cajas
dw_pallets dw_pallets
dw_etiquetas dw_etiquetas
pb_anyadir pb_anyadir
pb_eliminar pb_eliminar
dw_mp dw_mp
pb_2 pb_2
pb_3 pb_3
dw_promocion dw_promocion
pb_4 pb_4
pb_5 pb_5
end type

on pagina_1.create
this.dw_calidades=create dw_calidades
this.dw_cajas=create dw_cajas
this.dw_pallets=create dw_pallets
this.dw_etiquetas=create dw_etiquetas
this.pb_anyadir=create pb_anyadir
this.pb_eliminar=create pb_eliminar
this.dw_mp=create dw_mp
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_promocion=create dw_promocion
this.pb_4=create pb_4
this.pb_5=create pb_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_calidades
this.Control[iCurrent+2]=this.dw_cajas
this.Control[iCurrent+3]=this.dw_pallets
this.Control[iCurrent+4]=this.dw_etiquetas
this.Control[iCurrent+5]=this.pb_anyadir
this.Control[iCurrent+6]=this.pb_eliminar
this.Control[iCurrent+7]=this.dw_mp
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.pb_3
this.Control[iCurrent+10]=this.dw_promocion
this.Control[iCurrent+11]=this.pb_4
this.Control[iCurrent+12]=this.pb_5
end on

on pagina_1.destroy
call super::destroy
destroy(this.dw_calidades)
destroy(this.dw_cajas)
destroy(this.dw_pallets)
destroy(this.dw_etiquetas)
destroy(this.pb_anyadir)
destroy(this.pb_eliminar)
destroy(this.dw_mp)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_promocion)
destroy(this.pb_4)
destroy(this.pb_5)
end on

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 73
integer y = 24
integer width = 5623
integer height = 1492
string dataobject = "dw_articulos_conjunto1"
end type

event dw_pagina1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_articulos_tipo_ubicacion'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_tipo_ubicacion")
   OpenWithParm(wtc_mant_almacen_tipo_ubicacion,lstr_param)  			
CASE 'pb_ventipolin_codigo_por_defecto'		
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"ventipolin_codigo_por_defecto")
   OpenWithParm(wi_mant_ventipolin,lstr_param)  	
CASE 'pb_unidad'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"unidad")
   OpenWithParm(wi_mant_unidades,lstr_param)  
CASE 'pb_proveedor'
	lstr_param.s_argumentos[2]="P"
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"proveedor")
   OpenWithParm(wi_mant_clipro,lstr_param)  
CASE 'pb_cuenta'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta_contable")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pb_formato'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"formato")
   OpenWithParm(wi_mant_formatos,lstr_param)   
	CASE 'pb_formato_b'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_formato_prod")
   OpenWithParm(wi_mant_formatos,lstr_param)   
CASE 'pb_partidaest'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"partidaest")
   OpenWithParm(wi_mant_venpartidas,lstr_param)    	 	 	 	 	
CASE 'pb_mprima'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo_compras")
   OpenWithParm(w_mant_venmprima2,lstr_param)    	 	 	 	 	
case 'p_nuevo_ean'
	long   ll_nuevo_ean,ll_nuevo_ean_sga
	string ls_familia,ls_promocion,ls_prefijo_ean13,ls_prefijo_ean13_sga,ls_nuevo_ean,ls_ean13,ls_nuevo_ean_sga,ls_ean13_sga
	int    li_longitud_ean,li_longitud_prefijo,li_longitud_sufijo
	
	ls_familia   = apartados.pagina_2.dw_pagina2.object.familia[1]//this.object.familia[row]
	ls_promocion = this.object.articulos_promocion[1]
	
	if isnull(ls_familia) then ls_familia = ""
	
	if trim(ls_familia) <> "" or ls_promocion = 'S' then	
		/*
		ls_prefijo_ean13     = "8434768"
		ls_prefijo_ean13_sga = "29"	
		*/
		if ls_promocion <> 'S' then
			SELECT ltrim(rtrim(isnull(familias.prefijo_ean13,''))), 
					 ltrim(rtrim(isnull(familias.prefijo_ean13_sga,''))) 
			INTO   :ls_prefijo_ean13,
					 :ls_prefijo_ean13_sga 
			FROM   familias 
			WHERE  familias.empresa = :codigo_empresa
			AND    familias.codigo  = :ls_familia;
		else
			//La promocion solo lleva ean13_sga con codigo interno
			ls_prefijo_ean13     = ''
			ls_prefijo_ean13_sga = '29'	
		end if
		
		li_longitud_ean     = 12
		
		ls_ean13     = this.object.ean13[row]
		ls_ean13_sga = this.object.ean13_sga[row]
		
		if isnull(ls_ean13) then ls_ean13 = ""
		if isnull(ls_ean13_sga) then ls_ean13_sga = ""		
							
		if ls_ean13 = "" and trim(ls_prefijo_ean13) <> "" then	
			li_longitud_prefijo = len(ls_prefijo_ean13)
			li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo
			
			select isnull(max(convert(dec(12,0),substring(articulos.ean13,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
			into   :ll_nuevo_ean
			from   articulos
			where  articulos.empresa = :codigo_empresa
			and    isnull(articulos.ean13,'') <> ''
			and    substring(articulos.ean13,1,:li_longitud_prefijo) = :ls_prefijo_ean13;	
			
			ls_nuevo_ean = ls_prefijo_ean13+string(ll_nuevo_ean,left("000000000000",li_longitud_sufijo))
			ls_nuevo_ean = f_calcula_ean13(ls_nuevo_ean)
			
			this.object.ean13[row] = ls_nuevo_ean
		end if	
		
		if ls_ean13_sga = "" and trim(ls_prefijo_ean13_sga) <> "" then
			if ls_prefijo_ean13 = ls_prefijo_ean13_sga then
				this.object.ean13_sga[row] = this.object.ean13[row]
			else
				li_longitud_prefijo = len(ls_prefijo_ean13_sga)
				li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo			

				select isnull(max(convert(dec(12,0),substring(articulos.ean13_sga,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
				into   :ll_nuevo_ean_sga
				from   articulos
				where  articulos.empresa = :codigo_empresa
				and    isnull(articulos.ean13_sga,'') <> ''
				and    substring(articulos.ean13_sga,1,:li_longitud_prefijo) = :ls_prefijo_ean13_sga;	
								
//				select isnull(max(convert(dec(5,0),substring(articulos.ean13_sga,8,5))),0) + 1
//				into   :ls_nuevo_ean_sga
//				from   articulos
//				where  articulos.empresa = '1'
//				and    isnull(articulos.ean13_sga,'') <> ''
//				and    substring(articulos.ean13_sga,1,7) = :ls_prefijo_ean13_sga;	
				
				ls_nuevo_ean_sga = ls_prefijo_ean13_sga+string(ll_nuevo_ean_sga,left("000000000000",li_longitud_sufijo))
				ls_nuevo_ean_sga = f_calcula_ean13(ls_nuevo_ean_sga)
				
				this.object.ean13_sga[row] = ls_nuevo_ean_sga
			end if
		end if		
	else
		messagebox("¡Error!","No se puede asignar un EAN13 sin indicar la familia del articulo.")
	end if
END CHOOSE
end event

event dw_pagina1::itemchanged;string columna,v_familia,v_formato,v_modelo,v_subfamilia,v_subformato,v_uso,v_coleccion
string v_color,v_estilo,v_tono,v_sector,v_unidad, formato_etiqueta
dec{2} v_pesopieza, ancho_Std, largo_Std
Int decimales
string ls_objeto
str_parametros lstr_param


///////////////////////////////////////////////////////////////////////////////////////////////////
//					EXTRAEMOS LAS DESCRIPCIONES
///////////////////////////////////////////////////////////////////////////////////////////////////

IF dwo.Name = "formato" THEN
	dw_pag1.object.formatos_abreviado[row] = f_nombre_formato_Abr(codigo_empresa, data)

	select abreviado, ancho, largo
	into  :formato_etiqueta, :ancho_std, :largo_std
	from formatos 
	where empresa = :codigo_empresa
	and codigo = :data;
	
	dw_pag1.object.articulos_formato_etiqueta[row] = formato_etiqueta
	dw_pag1.object.articulos_ancho_std[row] = ancho_std
	dw_pag1.object.articulos_largo_std[row] = largo_std
END IF

IF (dwo.Name = "articulos_ancho_std" or dwo.Name = "articulos_largo_std") and dw_cajas.rowcount() > 0  THEN
		cb_insertar.TriggerEvent (clicked!)
		lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
		lstr_param.s_argumentos[2]  = sle_valor.text
		lstr_param.i_nargumentos    = 2
		OpenWithParm(wi_mant_articulocaja,lstr_param)
		dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
END IF

IF dwo.Name = "unidad" THEN
	dw_pag1.object.nombre_unidad[row] = f_nombre_unidad( data)//f_nombre_unidad_Abr( data)
	SELECT decimales INTO :decimales
	FROM unidades 
	WHERE codigo = :data;
	if isnull(decimales) then decimales = 0
	dw_pag1.object.articulos_decimales_unidad[row] = decimales
END IF

IF dwo.Name = "codigo_compras" THEN
	dw_pag1.object.venmprima_descripcion[row] = f_nombre_mprima(codigo_empresa, data)
END IF
IF dwo.Name = "partidaest" THEN
	dw_pag1.object.venpartidas_valor1[row] = f_valor1_venpartidas(codigo_empresa,data)
	dw_pag1.object.venpartidas_descripcion[row] = f_nombre_venpartidas(codigo_empresa,data)
END IF
///////////////////////////////////////////////////////////////////////////////////////////////////
//					FIN DE EXTRAER LAS DESCRIPCIONES
///////////////////////////////////////////////////////////////////////////////////////////////////

/*
IF dwo.Name = "articulos_promocion" THEN
	if data = 'S' then
		dw_etiquetas.visible = false
		dw_mp.visible = true
	else
		dw_etiquetas.visible = true
		dw_mp.visible = false
	end if
end if
*/
dw_pag1.accepttext()

columna = dwo.name

if columna = "unidad" then
	v_unidad = f_nombre_unidad_abr(data)

	if trim(v_unidad) = "" then
		messagebox("Atención","Unidad no valida.")		
		return 2	
	else
		return 0
	end if
end if

//if columna = "formato" then
//	v_formato = f_nombre_formato(codigo_empresa,data)
//
//	if trim(v_formato) = "" then
//		messagebox("Atención","Formato no valido.")		
//		return 2
//	else
//		return 0
//	end if
//end if

if columna = "control_stock" then
	if data = "S" then
		dw_pag1.object.stock_min.visible = TRUE
		dw_pag1.object.stock_minimo_text.visible = TRUE
		dw_pag1.object.nombre_unidad.visible = TRUE
	else
		dw_pag1.SetItem(This.GetRow(),"stock_min",0)
		dw_pag1.object.stock_min.visible = FALSE
		dw_pag1.object.stock_minimo_text.visible = FALSE
		dw_pag1.object.nombre_unidad.visible = FALSE
	end if
	return 0
end if

end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;string uni_est,uni,texto
uni     = This.GetItemString(row,"unidad")
uni_est = This.GetItemString(row,"unidad_est")
if isnull(uni_est) then uni_est = ""
 
if uni <>"" and uni_est="" then
	this.Setitem(row,"unidad_est",uni)
End if

if row <> 0 then
	if not isnull(dw_pagina1.object.articulos_descripcion[row]) then
		texto = trim(String(dw_pagina1.object.articulos_descripcion[row]))
		dw_pagina1.accepttext()
		dw_pagina1.object.articulos_descripcion[row] = texto
	END IF
end if

end event

event dw_pagina1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulos_tipo_ubicacion"
	bus_titulo     = "AYUDA SELECCION DE TIPOS DE UBICACION"
	bus_datawindow = "dw_ayuda_tipo_ubicacion"
	bus_filtro     = "" 		
CASE "ventipolin_codigo_por_defecto"		
	bus_titulo     = "AYUDA SELECCION DE TIPOS DE LINEA DE VENTAS"
	bus_datawindow = "dw_ayuda_ventipolin"
	bus_filtro     = "control_almacen = 'S'" 	
CASE "unidad"
	valor_empresa = FALSE
	bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
	bus_datawindow = "dw_ayuda_unidades"
CASE "proveedor"
	bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
	bus_filtro     = ""
	bus_datawindow = "dw_ayuda_proveedores_sector"
CASE "cuenta_contable"
	bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	bus_datawindow = "dw_ayuda_contaplan"
	bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
CASE "empleado"
	bus_titulo     = "VENTANA SELECCION DE EMPLEADOS"
	bus_datawindow = "dw_ayuda_empleados"
	bus_filtro     = "" 
CASE "familia"
	bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
	bus_datawindow = "dw_ayuda_familias"
	bus_filtro     = "" 
CASE "subfamilia"
   bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS "
	bus_datawindow = "dw_ayuda_subfamilias"
	bus_filtro     = "" 
CASE "formato"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = "" 
CASE "articulos_formato_prod"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = "" 
CASE "partidaest"
	bus_titulo     = "AYUDA SELECCION DE PARTIDAS ESTADISTICAS"
	bus_datawindow = "dw_ayuda_venpartidas"
	bus_filtro     = "" 
CASE "codigo_compras"
	bus_titulo     = "AYUDA SELECCION DE PARTIDAS ESTADISTICAS"
	bus_datawindow = "dw_ayuda_venmprima"
	bus_filtro     = "" 
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key


end event

event dw_pagina1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulos_tipo_ubicacion"
	bus_titulo     = "AYUDA SELECCION DE TIPOS DE UBICACION"
	bus_datawindow = "dw_ayuda_tipo_ubicacion"
	bus_filtro     = "" 		
CASE "ventipolin_codigo_por_defecto"		
	bus_titulo     = "AYUDA SELECCION DE TIPOS DE LINEA DE VENTAS"
	bus_datawindow = "dw_ayuda_ventipolin"
	bus_filtro     = "control_almacen = 'S'" 			
CASE "unidad"
	valor_empresa = FALSE
	bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
	bus_datawindow = "dw_ayuda_unidades"
CASE "proveedor"
	bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
	bus_filtro     = ""
	bus_datawindow = "dw_ayuda_proveedores_sector"
CASE "cuenta_contable"
	bus_titulo     = "VENTANA SELECCION DE CUENTAS"
	bus_datawindow = "dw_ayuda_contaplan"
	bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
CASE "empleado"
	bus_titulo     = "VENTANA SELECCION DE EMPLEADOS"
	bus_datawindow = "dw_ayuda_empleados"
	bus_filtro     = "" 
CASE "formato"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = ""
CASE "articulos_formato_prod"
	bus_titulo     = "AYUDA SELECCION DE FORMATOS"
	bus_datawindow = "dw_ayuda_formatos"
	bus_filtro     = ""
	
CASE "partidaest"
	bus_titulo     = "AYUDA SELECCION DE PARTIDAS ESTADISTICAS"
	bus_datawindow = "dw_ayuda_venpartidas"
	bus_filtro     = "" 
CASE "codigo_compras"
	bus_titulo     = "AYUDA SELECCION DE PARTIDAS ESTADISTICAS"
	bus_datawindow = "dw_ayuda_venmprima"
	bus_filtro     = "" 

CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_pagina1::retrieveend;string imagen,descrip,format

if rowcount = 1 then
	imagen = this.object.imagen[1]	
	descrip= this.object.articulos_descripcion[1]
	format = this.object.formato[1]
//	apartados.pagina_7.p_imagen.PictureName = imagen
//	apartados.pagina_7.st_7.text  = descrip
//	apartados.pagina_7.st_8.text  = f_nombre_formato(codigo_empresa,format)
//	apartados.pagina_6.st_10.text = descrip
//	apartados.pagina_6.st_9.text  = f_nombre_formato(codigo_empresa,format)
	apartados.pagina_3.st_12.text = descrip
	apartados.pagina_3.st_11.text = f_nombre_formato(codigo_empresa,format)
	apartados.pagina_2.st_14.text = descrip
	apartados.pagina_2.st_13.text = f_nombre_formato(codigo_empresa,format)
	apartados.pagina_5.st_16.text = descrip
	apartados.pagina_5.st_17.text = f_nombre_formato(codigo_empresa,format)
else
	apartados.pagina_7.p_imagen.PictureName = ""	
//	apartados.pagina_7.st_7.text  = ""
//	apartados.pagina_7.st_8.text  = ""
//	apartados.pagina_6.st_10.text = ""
//	apartados.pagina_6.st_9.text  = ""
	apartados.pagina_3.st_11.text = ""
	apartados.pagina_3.st_12.text = ""
	apartados.pagina_2.st_14.text = ""
	apartados.pagina_2.st_13.text = ""
	apartados.pagina_5.st_16.text = ""
	apartados.pagina_5.st_17.text = ""
end if
end event

event dw_pagina1::valores_numericos;f_valores_numericos(this,"unidad")
f_valores_numericos(this,"proveedor")
f_valores_numericos(this,"cuenta_contable")
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
event create ( )
event destroy ( )
integer width = 5673
integer height = 2692
string text = "Datos Ventas"
string picturename = "Custom048!"
long picturemaskcolor = 553648127
st_13 st_13
st_14 st_14
dw_tarifas dw_tarifas
cb_3 cb_3
r_4 r_4
dw_codestadistico dw_codestadistico
end type

on pagina_2.create
this.st_13=create st_13
this.st_14=create st_14
this.dw_tarifas=create dw_tarifas
this.cb_3=create cb_3
this.r_4=create r_4
this.dw_codestadistico=create dw_codestadistico
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_13
this.Control[iCurrent+2]=this.st_14
this.Control[iCurrent+3]=this.dw_tarifas
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.r_4
this.Control[iCurrent+6]=this.dw_codestadistico
end on

on pagina_2.destroy
call super::destroy
destroy(this.st_13)
destroy(this.st_14)
destroy(this.dw_tarifas)
destroy(this.cb_3)
destroy(this.r_4)
destroy(this.dw_codestadistico)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 160
integer width = 2144
integer height = 1096
string dataobject = "dw_articulos_conjunto7"
boolean border = true
end type

event dw_pagina2::itemchanged;
string columna,v_familia,v_formato,v_modelo,v_subfamilia,v_subformato,v_uso,v_coleccion, v_cliente, descripcion
string v_color,v_estilo,v_tono,v_sector,v_unidad
string v_marca, v_submarca
dec{2} v_pesopieza

///////////////////////////////////////////////////////////////////////////////////////////////////
//					EXTRAEMOS LAS DESCRIPCIONES
///////////////////////////////////////////////////////////////////////////////////////////////////

IF dwo.Name = "familia" THEN
	dw_pag2.object.familias_descripcion[row] = f_nombre_familia(codigo_empresa, data)
END IF

//if dwo.Name = "articulos_marcas_codigo" then
//	dw_pag2.object.marca_descripcion[row] = f_marcas_descripcion(codigo_empresa, dw_pag2.object.familia[row], data) 
//end if
//
//if dwo.mname = "articulos_submarcas_codigo" then
//	dw_pag2.object.submarca_descripcion[row] = f_submarcas_descripcion(codigo_empresa , dw_pag2.object.familia[row] , dw_pag2.object.articulos_marcas_codigo[row] , data ) 
//end if


IF dwo.Name = "subfamilia" THEN
	dw_pag2.object.subfamilias_descripcion[row] = f_nombre_subfamilia( codigo_empresa,data)
END IF

IF dwo.Name = "uso" THEN
	dw_pag2.object.almusos_descripcion[row] = f_nombre_almusos (codigo_empresa, data)
END IF

IF dwo.Name = "articulos_relieve" THEN
	SELECT descripcion INTO :descripcion FROM art_tipomoldura WHERE empresa = :codigo_empresa AND codigo = :data;
	if SQLCA.sqlcode <> 100 then
		dw_pag2.object.art_tipomoldura_descripcion[row] = descripcion
	else
		dwo.Primary[row] = ''
		dw_pag2.object.art_tipomoldura_descripcion[row] = ""
		return 2
	end if
END IF
///////////////////////////////////////////////////////////////////////////////////////////////////
//					FIN DE EXTRAER LAS DESCRIPCIONES
///////////////////////////////////////////////////////////////////////////////////////////////////




columna = dwo.name


if columna = "familia" then
	v_familia = f_nombre_familia(codigo_empresa,data)
end if



if columna = "subfamilia" then
//	v_subfamilia = f_nombre_subfamilia(codigo_empresa,data)
//
//	if trim(v_subfamilia) = "" then
//		messagebox("Atención","Subfamilia no valida.")		
//		return 2	
//	else
//		return 0
//	end if
end if
if columna = "subformato" then
	v_subformato = f_nombre_subformato(codigo_empresa,data)

	if trim(v_subformato) = "" then
		messagebox("Atención","Subformato no valido.")		
		return 2
	else
		return 0
	end if
end if


//if columna = "uso" then
//	v_uso = f_nombre_almusos(codigo_empresa,data)
//
//	if trim(v_uso) = "" then
//		messagebox("Atención","Uso no valido.")		
//		return 2
//	else
//		return 0
//	end if
//end if



//if columna = "coleccion" then
//	v_coleccion = f_nombre_almcolecciones(codigo_empresa,data)
//
//	if trim(v_coleccion) = "" then
//		messagebox("Atención","Colección no valida.")		
//		return 2
//	else
//		return 0
//	end if
//end if


if columna = "estilo" then
	v_estilo = f_nombre_almestilos(codigo_empresa,data)

	if trim(v_estilo) = "" then
		messagebox("Atención","Estilo no valido.")		
		return 2
	else
		return 0
	end if
end if
if columna = "tipo" then
	v_modelo = f_nombre_modelos(codigo_empresa,data)

	if trim(v_modelo) = "" then
		messagebox("Atención","Modelo no valido.")		
		return 2
	else
		return 0
	end if
end if





end event

event dw_pagina2::key;str_wt_busquedas_salida resultado

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulos_marcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE MARCAS"
	bus_datawindow = "dw_ayuda_marcas"
	bus_filtro     = "familias_codigo = '"+this.object.familia[this.getrow()]+"'" 
CASE "articulos_submarcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE SUBMARCAS"
	bus_datawindow = "dw_ayuda_submarcas"
	bus_filtro     = "familias_codigo = '"+this.object.familia[this.getrow()]+"' and marcas_codigo = '"+this.object.articulos_marcas_codigo[this.getrow()]+"'" 
CASE "familia"
	bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
	bus_datawindow = "dw_ayuda_familias"
	bus_filtro     = "" 
CASE "subfamilia"
   bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS "
	bus_datawindow = "dw_ayuda_subfamilias"
	bus_filtro     = "" 
CASE "subformato"
	bus_titulo     = "VENTANA SELECCION DE SUBFORMATOS "
 	bus_datawindow = "dw_ayuda_subformatos"
	bus_filtro     = "" 
CASE "uso"
	bus_titulo     = "VENTANA SELECCION DE USOS"
	bus_datawindow = "dw_ayuda_almusos"
	bus_filtro     = "" 		
CASE "estilo"
	bus_titulo     = "VENTANA SELECCION DE ESTILOS"
	bus_datawindow = "dw_ayuda_almestilos"
	bus_filtro     = "" 								
CASE "coleccion"
	bus_titulo     = "VENTANA SELECCION DE COLECCIONES"
	bus_datawindow = "dw_ayuda_almcolecciones"
	bus_filtro     = "" 								
CASE "color"
	bus_titulo     = "VENTANA SELECCION DE COLOR"
	bus_datawindow = "dw_ayuda_almcolores"
	bus_filtro     = "" 
CASE "cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 
CASE	"articulos_cliente_marca"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 
CASE "tipo"
	bus_titulo     = "VENTANA SELECCION DE MODELOS "
 	bus_datawindow = "dw_ayuda_modelo"
	bus_filtro     = "" 
CASE "articulos_colecciones_ccc"
	bus_titulo     = "VENTANA SELECCION DE COLECCIONES CCC "
 	bus_datawindow = "dw_ayuda_colecciones_ccc"
	bus_filtro     = "" 	
CASE "articulos_relieve"
//	bus_titulo     = "VENTANA SELECCION DE RELIEVES "
// 	bus_datawindow = "dw_ayuda_art_tipomoldura"
//	bus_filtro     = "" 	
	if key =  keyEnter! then
		Open(wtc_ayuda_busqueda_relieves)
		resultado = Message.PowerObjectParm
		if resultado.resultado = -1 then
			MessageBox("Error en la creación de la búsqueda",resultado.error)
		elseif resultado.resultado >= 4 then
			if not isnull(resultado.valores[3]) and resultado.valores[3] <> "" then
				if resultado.valores[3] <> this.object.cliente[this.getrow()] then
					MessageBox("Error", "El relieve seleccionado es exclusivo del cliente "+resultado.valores[4]+". Seleccione otro relieve antes de continuar.")
					return
				end if
			end if
			this.object.articulos_relieve[this.getrow()] = resultado.valores[1]
			this.object.art_tipomoldura_descripcion[this.getrow()] = resultado.valores[2]
		end if
	end if
CASE ELSE
	SetNull(bus_campo)
END CHOOSE

CALL Super::Key


end event

event dw_pagina2::rbuttondown;str_wt_busquedas_salida resultado

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "articulos_marcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE MARCAS"
	bus_datawindow = "dw_ayuda_marcas"
	bus_filtro     = "familias_codigo = '"+this.object.familia[row]+"'" 
CASE "articulos_submarcas_codigo"
	bus_titulo     = "AYUDA SELECCION DE SUBMARCAS"
	bus_datawindow = "dw_ayuda_submarcas"
	bus_filtro     = "familias_codigo = '"+this.object.familia[row]+"' and marcas_codigo = '"+this.object.articulos_marcas_codigo[row]+"'" 
CASE "familia"
	bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
	bus_datawindow = "dw_ayuda_familias"
	bus_filtro     = "" 
CASE "subfamilia"
   bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS "
	bus_datawindow = "dw_ayuda_subfamilias"
	bus_filtro     = "" 
CASE "subformato"
	bus_titulo     = "VENTANA SELECCION DE SUBFORMATOS "
 	bus_datawindow = "dw_ayuda_subformatos"
	bus_filtro     = "" 
CASE "uso"
	bus_titulo     = "VENTANA SELECCION DE USOS"
	bus_datawindow = "dw_ayuda_almusos"
	bus_filtro     = "" 		
CASE "estilo"
	bus_titulo     = "VENTANA SELECCION DE ESTILOS"
	bus_datawindow = "dw_ayuda_almestilos"
	bus_filtro     = "" 								
CASE "coleccion"
	bus_titulo     = "VENTANA SELECCION DE COLECCIONES"
	bus_datawindow = "dw_ayuda_almcolecciones"
	bus_filtro     = "" 								
CASE "color"
	bus_titulo     = "VENTANA SELECCION DE COLOR"
	bus_datawindow = "dw_ayuda_almcolores"
	bus_filtro     = "" 
CASE "cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE "articulos_cliente_marca"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 
CASE "tipo"
	bus_titulo     = "VENTANA SELECCION DE MODELOS "
 	bus_datawindow = "dw_ayuda_modelo"
	bus_filtro     = ""
CASE "articulos_colecciones_ccc"
	bus_titulo     = "VENTANA SELECCION DE COLECCIONES CCC "
 	bus_datawindow = "dw_ayuda_colecciones_ccc"
	bus_filtro     = "" 
CASE "articulos_relieve"
//	bus_titulo     = "VENTANA SELECCION DE RELIEVES "
// 	bus_datawindow = "dw_ayuda_art_tipomoldura"
//	bus_filtro     = ""
	Open(wtc_ayuda_busqueda_relieves)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado >= 4 then
		if not isnull(resultado.valores[3]) and resultado.valores[3] <> "" then
			if resultado.valores[3] <> this.object.cliente[this.getrow()] then
				MessageBox("Error", "El relieve seleccionado es exclusivo del cliente "+resultado.valores[4]+". Seleccione otro relieve antes de continuar.")
				return
			end if
		end if
		this.object.articulos_relieve[this.getrow()] = resultado.valores[1]
		this.object.art_tipomoldura_descripcion[this.getrow()] = resultado.valores[2]
	end if
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown


end event

event dw_pagina2::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_articulos_marcas_codigo'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_marcas_codigo")
	OpenWithParm(wi_mant_marcas,lstr_param)  
CASE 'pb_articulos_submarcas_codigo'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"articulos_submarcas_codigo")
	OpenWithParm(wi_mant_submarcas,lstr_param)  
CASE 'pb_coleccion'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"coleccion")
	OpenWithParm(wi_mant_almcolecciones,lstr_param)  
CASE 'pb_color'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"color")
	OpenWithParm(wi_mant_almcolores,lstr_param)  
CASE 'pb_uso'
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"uso")
	OpenWithParm(wi_mant_almusos,lstr_param)  
CASE 'p_relieve'
	lstr_param.i_nargumentos    = 1
	lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_relieve")
	OpenWithParm(w_mant_art_tipomoldura,lstr_param)  
CASE 'p_marca'
	lstr_param.i_nargumentos    = 1
	lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_cliente_marca")
	OpenWithParm(wtc_mant_clientes,lstr_param)  
CASE 'pb_familia'
	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[1]=codigo_empresa
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"familia")
	OpenWithParm(wi_mant_familias,lstr_param)  
CASE 'pb_subfamilia'
	lstr_param.i_nargumentos    = 1
	lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"subfamilia")
	OpenWithParm(wi_mant_subfamilias,lstr_param)  
CASE 'pb_colecciones_ccc'
	lstr_param.i_nargumentos    = 1
	lstr_param.s_argumentos[1]=GetItemString(This.GetRow(),"articulos_colecciones_ccc")
	OpenWithParm(wtc_mant_colecciones_ccc,lstr_param)  	

END CHOOSE



end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
event create ( )
event destroy ( )
integer width = 5673
integer height = 2692
string text = "Idiomas"
string picturename = "Custom011!"
long picturemaskcolor = 553648127
st_11 st_11
st_12 st_12
gb_3 gb_3
cb_insertar_idiomas cb_insertar_idiomas
cb_borrar_idiomas cb_borrar_idiomas
end type

on pagina_3.create
this.st_11=create st_11
this.st_12=create st_12
this.gb_3=create gb_3
this.cb_insertar_idiomas=create cb_insertar_idiomas
this.cb_borrar_idiomas=create cb_borrar_idiomas
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_11
this.Control[iCurrent+2]=this.st_12
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.cb_insertar_idiomas
this.Control[iCurrent+5]=this.cb_borrar_idiomas
end on

on pagina_3.destroy
call super::destroy
destroy(this.st_11)
destroy(this.st_12)
destroy(this.gb_3)
destroy(this.cb_insertar_idiomas)
destroy(this.cb_borrar_idiomas)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 14
integer y = 144
integer width = 2857
integer height = 688
string dataobject = "dw_almcliartdesc_conjunto"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina3::itemchanged;dec{0} max_orden,orden
string cliente,cliente_aux,columna
long   donde,i,total

max_orden = 0
total   = dw_pagina3.rowcount()
donde   = dw_pagina3.getrow()
cliente = dw_pagina3.getitemstring(donde,"cliente")
columna = dwo.name
if columna = "descripcion" then
	if nuevo_idioma = "S" then
		for i = 1 to total
			cliente_aux = dw_pagina3.getitemstring(i,"cliente")
			if cliente_aux = cliente then
				orden = dw_pagina3.getitemnumber(i,"orden")
				if orden > max_orden then
					max_orden = orden
				end if
			end if
		next
		max_orden = max_orden + 1
		dw_pagina3.setitem(donde,"orden",max_orden)
	end if
end if
end event

event dw_pagina3::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key


end event

event dw_pagina3::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "cliente"
	bus_titulo     = "AYUDA SELECCION CLIENTES"
	bus_datawindow = "dw_ayuda_clientes"
	bus_filtro     = "" 	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown

end event

event dw_pagina3::ue_valores;call super::ue_valores;ue_marca_linea=true
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
boolean visible = false
integer width = 5673
integer height = 2692
string text = "Ficha Técnica"
end type

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 238
integer y = 164
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 5673
integer height = 2692
string text = "Datos Producción"
string picturename = "Custom096!"
long picturemaskcolor = 553648127
st_17 st_17
st_16 st_16
dw_listado_ficha dw_listado_ficha
r_3 r_3
rr_1 rr_1
cb_1 cb_1
r_5 r_5
pb_1 pb_1
r_6 r_6
cb_traspaso cb_traspaso
cb_copiar_parametros cb_copiar_parametros
pb_anyade_grupo pb_anyade_grupo
pb_borra_grupo pb_borra_grupo
dw_grupo_combi dw_grupo_combi
end type

on pagina_5.create
this.st_17=create st_17
this.st_16=create st_16
this.dw_listado_ficha=create dw_listado_ficha
this.r_3=create r_3
this.rr_1=create rr_1
this.cb_1=create cb_1
this.r_5=create r_5
this.pb_1=create pb_1
this.r_6=create r_6
this.cb_traspaso=create cb_traspaso
this.cb_copiar_parametros=create cb_copiar_parametros
this.pb_anyade_grupo=create pb_anyade_grupo
this.pb_borra_grupo=create pb_borra_grupo
this.dw_grupo_combi=create dw_grupo_combi
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_17
this.Control[iCurrent+2]=this.st_16
this.Control[iCurrent+3]=this.dw_listado_ficha
this.Control[iCurrent+4]=this.r_3
this.Control[iCurrent+5]=this.rr_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.r_5
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.r_6
this.Control[iCurrent+10]=this.cb_traspaso
this.Control[iCurrent+11]=this.cb_copiar_parametros
this.Control[iCurrent+12]=this.pb_anyade_grupo
this.Control[iCurrent+13]=this.pb_borra_grupo
this.Control[iCurrent+14]=this.dw_grupo_combi
end on

on pagina_5.destroy
call super::destroy
destroy(this.st_17)
destroy(this.st_16)
destroy(this.dw_listado_ficha)
destroy(this.r_3)
destroy(this.rr_1)
destroy(this.cb_1)
destroy(this.r_5)
destroy(this.pb_1)
destroy(this.r_6)
destroy(this.cb_traspaso)
destroy(this.cb_copiar_parametros)
destroy(this.pb_anyade_grupo)
destroy(this.pb_borra_grupo)
destroy(this.dw_grupo_combi)
end on

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 325
integer y = 152
integer width = 2560
integer height = 724
string dataobject = "dw_articulos_conjunto3"
boolean border = true
end type

event dw_pagina5::key;String uso, modelo, coleccion

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "VENTANA SELECCION MOLDES "
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro = "activo = 'S'"
CASE "marco"
	bus_titulo     = "VENTANA SELECCION MARCOS"
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro="molde = '"+string(this.object.molde[this.getrow()])+"' and activo = 'S'"

	
CASE "plato_sup"
	bus_titulo     = "VENTANA SELECCION PLATOS "
	bus_filtro     = "molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Superior'"
	bus_datawindow = "dw_ayuda_prodplatos"
CASE "plato_inf"
	bus_titulo     = "VENTANA SELECCION PLATOS "
	bus_filtro     = "molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Inferior'"
	bus_datawindow = "dw_ayuda_prodplatos"
CASE "articulos_costilla"
	bus_titulo     = "VENTANA SELECCION COSTILLA "
	bus_datawindow = "dw_ayuda_costilla"

CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key


end event

event dw_pagina5::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_articulos_conjunto_nuevo"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_molde'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"molde")
   OpenWithParm(wi_mant_prodmoldes,lstr_param)  
CASE 'pb_marco'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"marco")
   OpenWithParm(wtc_mant_marcos, lstr_param)  
CASE 'pb_plato_sup'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"plato_sup")
   OpenWithParm(wi_mant_prodplatos,lstr_param)  
CASE 'pb_plato_inf'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"plato_inf")
   OpenWithParm(wi_mant_prodplatos,lstr_param)  

END CHOOSE
end event

event dw_pagina5::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "VENTANA SELECCION MOLDES "
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro="activo = 'S'"
CASE "marco"
	bus_titulo     = "VENTANA SELECCION MARCOS"
	bus_datawindow = "dw_ayuda_prodmarcos"
CASE "plato_sup"
	bus_titulo     = "VENTANA SELECCION PLATOS "
	bus_filtro     = "molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Superior'"
	bus_datawindow = "dw_ayuda_prodplatos"
CASE "plato_inf"
	bus_titulo     = "VENTANA SELECCION PLATOS "
	bus_filtro     = "molde = '" +string(this.object.molde[this.GetRow()])+"' and  tipo = 'Inferior'"
	bus_datawindow = "dw_ayuda_prodplatos"
CASE "articulos_costilla"
	bus_titulo     = "VENTANA SELECCION COSTILLA "
	bus_datawindow = "dw_ayuda_costilla"

CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
boolean visible = false
integer width = 5673
integer height = 2692
string text = "Rutas"
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 5673
integer height = 2692
string text = "Imagen"
string picturename = "Custom085!"
long picturemaskcolor = 553648127
p_imagen p_imagen
dw_imagen dw_imagen
pb_archivos_modelo pb_archivos_modelo
st_7 st_7
end type

on pagina_7.create
this.p_imagen=create p_imagen
this.dw_imagen=create dw_imagen
this.pb_archivos_modelo=create pb_archivos_modelo
this.st_7=create st_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_imagen
this.Control[iCurrent+2]=this.dw_imagen
this.Control[iCurrent+3]=this.pb_archivos_modelo
this.Control[iCurrent+4]=this.st_7
end on

on pagina_7.destroy
call super::destroy
destroy(this.p_imagen)
destroy(this.dw_imagen)
destroy(this.pb_archivos_modelo)
destroy(this.st_7)
end on

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
boolean visible = false
integer x = 1038
integer y = 60
integer width = 2290
integer height = 108
string dataobject = "dw_articulos_conjunto5"
end type

event dw_pagina7::itemchanged;string ruta,fichero

if cb_insertar.enabled then
	if dwo.name = "pb_imagen" then
		if GetFileOpenName("Seleccione Imagen",ruta,fichero,"BMP","Bitmaps (*.BMP),*.BMP") = 1 then
			p_imagen.PictureName = ruta
			dw_pag1.object.imagen[row] = ruta
			this.setcolumn("imagen")
		end if
	end if
end if

end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 5673
integer height = 2692
string text = "Pastas/Calibres"
string picturename = "CheckOut1!"
dw_3 dw_3
dw_2 dw_2
pb_añadir pb_añadir
pb_borrar pb_borrar
end type

on pagina_8.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.pb_añadir=create pb_añadir
this.pb_borrar=create pb_borrar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.pb_añadir
this.Control[iCurrent+4]=this.pb_borrar
end on

on pagina_8.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.pb_añadir)
destroy(this.pb_borrar)
end on

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
boolean visible = false
integer x = 4352
integer y = 292
integer width = 512
integer height = 180
integer taborder = 0
boolean enabled = false
end type

type dw_calidades from datawindow within pagina_1
boolean visible = false
integer x = 69
integer y = 1520
integer width = 686
integer height = 416
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_articuloscal_conjunto"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)
	CASE 'pb_carpeta'
		lstr_param.s_titulo_ventana = "Mantenimiento de Calidades por Articulo"
		lstr_param.s_argumentos[2]  = sle_valor.Text
		lstr_param.i_nargumentos    = 2
		OpenWithParm(wi_mant_almartcal, lstr_param)
		dw_calidades.Retrieve(codigo_empresa,sle_valor.Text)
END CHOOSE

end event

type dw_cajas from datawindow within pagina_1
boolean visible = false
integer x = 759
integer y = 1520
integer width = 1093
integer height = 416
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_articuloscaja_conjunto"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)
	CASE 'pb_carpeta'	
		lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
		lstr_param.s_argumentos[2]  = sle_valor.text
		lstr_param.i_nargumentos    = 2
		OpenWithParm(wi_mant_articulocaja,lstr_param)
		dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
END CHOOSE

end event

type dw_pallets from datawindow within pagina_1
boolean visible = false
integer x = 1856
integer y = 1520
integer width = 1481
integer height = 416
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_palarticulos_conjunto"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string ls_objeto,codigo
str_parametros lstr_param

codigo = dw_pag1.getitemString(dw_pag1.getrow(),"codigo")

CHOOSE CASE f_objeto_datawindow(This)
   CASE 'pb_carpeta'
			lstr_param.s_titulo_ventana = "Mantenimiento de Pallets por Artículo y Caja"
			lstr_param.s_argumentos[2]  = string(codigo)
	      lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_palarticulo, lstr_param)
			dw_pallets.Retrieve(codigo_empresa,codigo,sle_valor.text)
END CHOOSE

end event

event doubleclicked;//if row=0 then Return
//
//String codpallet,articulo,clase
//codpallet = dw_pallets.GetItemString(dw_pallets.GetRow(),"codigo")
//articulo  = sle_valor.text
//integer bien=0,cuantos
//
//// Verifica si esta el tipo de pallet seleccionado
//
//  SELECT almartpallet.pallet  
//    INTO :codpallet
//    FROM almartpallet  
//   WHERE ( almartpallet.empresa  = :codigo_empresa ) AND  
//	      ( almartpallet.articulo = :articulo       ) AND  
//         ( almartpallet.pallet   = :codpallet      );
//
//
//IF SQLCA.SQLCode = 0 THEN
// 		DELETE FROM almartpallet
//      WHERE ( almartpallet.empresa  = :codigo_empresa ) AND  
//	         ( almartpallet.articulo = :articulo       ) AND  
//            ( almartpallet.pallet   = :codpallet      ) USING SQLCA;
//				IF SQLCA.SQLCode<>0 THEN  bien=1
//				IF bien=1 THEN
//						ROLLBACK USING SQLCA;
//						MessageBox("Problemas en la transaccion", &
//									  "No se puede Grabar El tipo de pallet", &
//										Exclamation!, Ok!, 2)
//					 ELSE
//						COMMIT USING SQLCA;
//			   END IF
//
//  ELSE
//	   // verifica si existe alguna linea al mismo tipo de pallet
//		clase = f_clase_pallets(codigo_empresa,codpallet)
//		
//		select count(*)
//		into :cuantos
//		from almartpallet
//		Where almartpallet.empresa       = :codigo_empresa
//		  and almartpallet.articulo      = :articulo
//		  and almartpallet.clase_pallet  = :clase;
//      
//		IF cuantos<> 0 THEN
//			   MessageBox("Problemas en la selección", &
//    			  "No se pueden grabar 2 del mismo tipo de pallet", &
//					Exclamation!, Ok!, 2)
//
// 		 else
//			INSERT INTO almartpallet
//					 ( empresa,articulo,pallet,clase_pallet)
//			VALUES ( :codigo_empresa,:articulo,:codpallet,:clase)
//					 using SQLCA;
//					 IF SQLCA.SQLCode<>0 THEN  bien=1
//					 
//					 IF bien=1 THEN
//							ROLLBACK USING SQLCA;
//							MessageBox("Problemas en la transaccion", &
//										  "No se puede Grabar El tipo de pallet", &
//											Exclamation!, Ok!, 2)
//						ELSE
//							COMMIT USING SQLCA;
//                END IF
//
//		End if
//End if
//	
//
//
//dw_pallets.Retrieve(codigo_empresa,sle_valor.text)
end event

type dw_etiquetas from u_dw within pagina_1
event pr1 pbm_dwnitemchangefocus
integer x = 5
integer y = 1928
integer width = 3269
integer height = 744
integer taborder = 40
boolean bringtotop = true
string dataobject = "dwtc_articulos_etiqueta"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta
string codigo_etiqueta, etiqueta, ruta_etiquetas, comando,ls_caja,ls_pallet,ls_tono,ls_calibre,ls_tono_cliente,ls_calibre_cliente,ls_calidad,ls_valor,ls_dato_falta
boolean lb_faltan_datos

if not(cb_insertar.enabled)  then
	dw_pagina1.triggerevent(clicked!)
end if

CHOOSE CASE dwo.name
	CASE "p_editar_impresion"
		this.setredraw(false)
		if this.object.editar_datos_a_imprimir[row] = 0 then
			this.object.editar_datos_a_imprimir[row] = 1
			
			if apartados.pagina_1.dw_pagina1.rowcount() = 1 then
				ls_tono            = apartados.pagina_1.dw_pagina1.object.tono[1]
				ls_calibre         = apartados.pagina_1.dw_pagina1.object.calibre[1]
				ls_tono_cliente    = apartados.pagina_1.dw_pagina1.object.tono_cliente[1]
				ls_calibre_cliente = apartados.pagina_1.dw_pagina1.object.calibre_cliente[1]
				
				if apartados.pagina_1.dw_calidades.rowcount() > 0 then
					ls_calidad      = apartados.pagina_1.dw_calidades.object.calidad[1]
				else
					ls_calidad      = ''
				end if
			else
				ls_tono            = 'N'
				ls_calibre         = 'N'
				ls_tono_cliente    = 'N'
				ls_calibre_cliente = 'N'
				ls_calidad         = ''
			end if
			
			if ls_tono = 'S' then
				this.SetTabOrder ('lote',20)
			else
				this.SetTabOrder ('lote',0)
				this.object.lote[row] = ''
			end if

			if ls_calibre = 'S' then
				this.SetTabOrder ('calibre',30)
			else
				this.SetTabOrder ('calibre',0)
				this.object.calibre[row] = 0
			end if

			this.object.calidad[row] = ls_calidad
		
			if ls_tono_cliente = 'S' then
				this.SetTabOrder ('tono_cliente',50)
			else
				this.SetTabOrder ('tono_cliente',0)
				this.object.tono_cliente[row] = ''
			end if

			if ls_calibre_cliente = 'S' then
				this.SetTabOrder ('calibre_cliente',60)
			else
				this.SetTabOrder ('calibre_cliente',0)
				this.object.calibre_cliente[row] = 0
			end if						
			
		else
			this.object.editar_datos_a_imprimir[row] = 0
		end if
		this.sort()
		this.groupcalc()
		this.scrolltorow(row)		
		this.setredraw(true)
		this.setcolumn("lote")
	CASE "p_cerrar"
		this.object.editar_datos_a_imprimir[row] = 0
		this.sort()
		this.groupcalc()
		this.scrolltorow(row)
	CASE "p_nuevo"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_etiquetas")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.articulos_etiqueta_etiqueta[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "w_mant_articulos_tencer"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_etiquetas, lstr_param)
		
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
	CASE "p_imprimir"			
//			codigo_etiqueta = dw_etiquetas.object.articulos_etiqueta_etiqueta[row]
//			SELECT almetiquetas.ruta
//			into :etiqueta
//		   	FROM almetiquetas 
//   			WHERE  almetiquetas.empresa = :codigo_empresa 
//         	AND     almetiquetas.codigo = :codigo_etiqueta;
//				
//			select ruta_etiquetas
//			into :ruta_etiquetas
//			from empresas
//			where empresa = :codigo_empresa;
//		
//			comando = '"c:\Program Files (x86)\Labeljoy 5\Labeljoy5.exe" '+ruta_etiquetas+etiqueta
//			run (comando, Maximized!)
			this.accepttext()
			
			lb_faltan_datos = false
			
			if dec(this.describe('lote.tabsequence')) > 0 then
				if this.object.lote[row] = '' then
					lb_faltan_datos = true
					ls_dato_falta = 'lote'
				end if
			end if
			
			if not(lb_faltan_datos) then
				if dec(this.describe('calibre.tabsequence')) > 0 then
					if this.object.calibre[row] = 0 then
						lb_faltan_datos = true
						ls_dato_falta = 'calibre'
					end if
				end if				
			end if
			
			if not(lb_faltan_datos) then
				if dec(this.describe('tono_cliente.tabsequence')) > 0 then
					if this.object.tono_cliente[row] = '' then
						lb_faltan_datos = true
						ls_dato_falta = 'tono_cliente'
					end if
				end if				
			end if			
						
			if not(lb_faltan_datos) then
				if dec(this.describe('calibre_cliente.tabsequence')) > 0 then
					if this.object.calibre_cliente[row] = 0 then
						lb_faltan_datos = true
						ls_dato_falta = 'calibre_cliente'
					end if
				end if				
			end if									
			
			if not(lb_faltan_datos) then
				if dec(this.describe('calidad.tabsequence')) > 0 then
					if this.object.calidad[row] = '' then
						lb_faltan_datos = true
						ls_dato_falta = 'calidad'
					end if
				end if				
			end if												
			
			if lb_faltan_datos then
				messagebox("Error","Debe introducir el dato de: "+ls_dato_falta)
				this.setcolumn(ls_dato_falta)
			else			
				select isnull(palarticulo.codigo,''),
						 isnull(almartcajas.caja,'') 
				into   :ls_pallet,
						 :ls_caja 
				from   palarticulo,
						 almartcajas 
				where  palarticulo.empresa    = almartcajas.empresa 
				and    palarticulo.articulo   = almartcajas.articulo 
				and    palarticulo.caja       = almartcajas.caja 
				and    palarticulo.empresa    = :codigo_empresa
				and    palarticulo.articulo   = :sle_valor.text
				and    palarticulo.pordefecto = 'S'
				and    almartcajas.pordefecto = 'S';			
				
				codigo_etiqueta = dw_etiquetas.object.articulos_etiqueta_etiqueta[row]
	
				//f_imprimir_etiqueta_labeljoy(articulo,calidad,lote,calibre,caja,etiqueta,copias)
				f_imprimir_etiqueta_labeljoy(sle_valor.text,this.object.calidad[row],this.object.lote[row],this.object.calibre[row],ls_pallet,ls_caja,codigo_etiqueta,3,this.object.tono_cliente[row],this.object.calibre_cliente[row],this.object.pedido_cliente[row])
			end if		
END CHOOSE

/*
if row > 0 then
	filtro_general(row, 0, 0)
end if
*/

end event

event itemchanged;call super::itemchanged;string resultado, resultado2,ls_calidad,ls_articulo,ls_calidades_descripcion

//this.Accepttext()

CHOOSE CASE dwo.name
	CASE "articulos_etiqueta_etiqueta"
		SELECT descripcion, observaciones
		INTO :resultado, :resultado2
		FROM almetiquetas 
		WHERE empresa = :codigo_empresa AND codigo = :data;
		if SQLCA.sqlcode <> 100 then
			this.object.almetiquetas_descripcion[Row] 	= resultado
			this.object.almetiquetas_observaciones[Row]	= resultado2
		else
			dwo.Primary[row] = ''
			this.object.almetiquetas_descripcion[Row] 	= ''
			this.object.almetiquetas_observaciones[Row] = ''
			return 2			
		end if
	CASE "calidad"
		ls_calidad  = data

		ls_articulo = sle_valor.text
		
		if not isnull(ls_articulo) and ls_articulo <> "" then
			SELECT calidades.descripcion
			into :ls_calidades_descripcion
			FROM almartcal 
			INNER JOIN calidades ON almartcal.empresa = calidades.empresa AND almartcal.calidad = calidades.codigo 
			WHERE almartcal.empresa = :codigo_empresa 
			AND almartcal.articulo = :ls_articulo 
			and almartcal.calidad= :ls_calidad
			USING SQLCA;
			
			if SQLCA.sqlcode <> 100 then
				//Correcto
			else
				return 2			
			end if
		else
			return 2			
		end if		
END CHOOSE


//this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, modelo, cliente, propuesta, coleccion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
Int repetidos, propuestas, i, j
Boolean cambiar_dependencias

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "articulos_etiqueta_etiqueta"
			busqueda.titulo_ventana = "Búsqueda de Etiquetas"
			
			busqueda.consulta  = " SELECT codigo, descripcion, observaciones "+&
										" FROM almetiquetas "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY CONVERT(integer, codigo) ASC "
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[2] = "Observaciones"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				
				this.object.articulos_etiqueta_etiqueta[this.GetRow()] = resultado.valores[1]		
				this.object.almetiquetas_descripcion[this.GetRow()] = resultado.valores[2]	
				this.object.almetiquetas_observaciones[this.GetRow()] = resultado.valores[3]		
					
			end if
	END CHOOSE
end if	
	
end event

type pb_anyadir from picturebutton within pagina_1
integer x = 101
integer y = 2540
integer width = 146
integer height = 128
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
end type

event clicked;long fila_actual
string articulo_actual

if not(cb_insertar.enabled)  then
	dw_pagina1.triggerevent(clicked!)
end if

articulo_actual = sle_valor.text

if isnull(articulo_actual) or articulo_actual = "" then
	MessageBox("Error","Debe seleccionar un articulos para poder insertar una nueva etiqueta")
	return
end if

fila_actual = apartados.pagina_1.dw_etiquetas.InsertRow(0)

if fila_actual > 0 then
	apartados.pagina_1.dw_etiquetas.object.articulos_etiqueta_empresa[fila_actual] = codigo_empresa
	apartados.pagina_1.dw_etiquetas.object.articulos_etiqueta_articulo[fila_actual] = articulo_actual
end if

apartados.pagina_1.dw_etiquetas.accepttext()
end event

type pb_eliminar from picturebutton within pagina_1
integer x = 270
integer y = 2540
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
end type

event clicked;Boolean error_borrando
Long fila_actual


if not(cb_insertar.enabled)  then
	dw_pagina1.triggerevent(clicked!)
end if

if apartados.pagina_1.dw_etiquetas.rowcount() <= 0 then
	return
end if

fila_actual = apartados.pagina_1.dw_etiquetas.getrow()
if apartados.pagina_1.dw_etiquetas.DeleteRow(fila_actual) <> 1 then
	error_borrando = True
else
	error_borrando = False
end if


if error_borrando then
	MessageBox("Error","No ha sido posible borrar la etiqueta")
end if


end event

type dw_mp from u_dw within pagina_1
event pr1 pbm_dwnitemchangefocus
boolean visible = false
integer x = 3739
integer y = 24
integer width = 2107
integer height = 1184
integer taborder = 60
boolean bringtotop = true
string dataobject = "dwtc_articulos_venmprima"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "articulos_venmprima_mprima"
		SELECT descripcion 
		INTO :resultado 
		FROM venmprima 
		WHERE empresa = :codigo_empresa AND codigo = :data;
		if SQLCA.sqlcode <> 100 then
			this.object.venmprima_descripcion[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.venmprima_descripcion[Row] 	= ''
			return 2			
		end if

END CHOOSE


this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, modelo, cliente, propuesta, coleccion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
Int repetidos, propuestas, i, j
Boolean cambiar_dependencias

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "articulos_venmprima_mprima"
			busqueda.titulo_ventana = "Búsqueda de Materias Primas"
			
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM venmprima "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY CONVERT(integer, codigo) ASC "
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				
				this.object.articulos_venmprima_mprima[this.GetRow()] = resultado.valores[1]		
				this.object.venmprima_descripcion[this.GetRow()] = resultado.valores[2]	
				this.object.articulos_venmprima_cantidad[this.GetRow()] = 0
					
			end if
	END CHOOSE
end if	
	
end event

event clicked;call super::clicked;if not(cb_insertar.enabled)  then
	dw_pagina1.triggerevent(clicked!)
end if
end event

type pb_2 from picturebutton within pagina_1
boolean visible = false
integer x = 3771
integer y = 940
integer width = 146
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
end type

event clicked;
long fila_actual
string articulo_actual

if not(cb_insertar.enabled)  then
	dw_pag1.triggerevent(clicked!)
end if

articulo_actual = sle_valor.text

if isnull(articulo_actual) or articulo_actual = "" then
	MessageBox("Error","Debe seleccionar un articulos para poder insertar una nueva materia prima")
	return
end if

fila_actual = apartados.pagina_1.dw_mp.InsertRow(0)

if fila_actual > 0 then
	apartados.pagina_1.dw_mp.object.articulos_venmprima_empresa[fila_actual] = codigo_empresa
	apartados.pagina_1.dw_mp.object.articulos_venmprima_articulo[fila_actual] = articulo_actual
end if

apartados.pagina_1.dw_mp.accepttext()

end event

type pb_3 from picturebutton within pagina_1
boolean visible = false
integer x = 3936
integer y = 940
integer width = 146
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
end type

event clicked;
Boolean error_borrando
Long fila_actual


if not(cb_insertar.enabled)  then
	dw_pag1.triggerevent(clicked!)
end if

if apartados.pagina_1.dw_mp.rowcount() <= 0 then
	return
end if

fila_actual = apartados.pagina_1.dw_mp.getrow()
if apartados.pagina_1.dw_mp.DeleteRow(fila_actual) <> 1 then
	error_borrando = True
else
	error_borrando = False
end if


if error_borrando then
	MessageBox("Error","No ha sido posible borrar la etiqueta")
end if



end event

type dw_promocion from u_dw within pagina_1
event pr1 pbm_dwnitemchangefocus
boolean visible = false
integer x = 3758
integer y = 1540
integer width = 2107
integer height = 1128
integer taborder = 22
boolean bringtotop = true
string dataobject = "dwtc_aux_articulo_promocion"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;call super::itemchanged;string resultado, resultado2

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "articulo_promocion_articulo"
		SELECT articulos.descripcion,  formatos.abreviado
		INTO :resultado, :resultado2 
		FROM articulos 
		LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo 
		WHERE articulos.empresa = :codigo_empresa AND articulos.codigo = :data;
		if SQLCA.sqlcode <> 100 then
			this.object.articulos_descripcion[Row] 	= resultado
			this.object.formatos_abreviado[Row] 	= resultado2
		else
			dwo.Primary[row] = ''
			this.object.articulos_descripcion[Row] 	= ''
			this.object.formatos_abreviado[Row] 	= ''
			return 2			
		end if
		this.object.articulo_promocion_cantidad[row] = 0

END CHOOSE


this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, modelo, cliente, propuesta, coleccion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda
Int repetidos, propuestas, i, j
Boolean cambiar_dependencias

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "articulo_promocion_articulo"
			busqueda.titulo_ventana = "Búsqueda de Artículos"
			
			busqueda.consulta  = " SELECT articulos.codigo, articulos.descripcion, formatos.abreviado "+&
										" FROM articulos LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
										" WHERE articulos.empresa = '"+codigo_empresa+"' AND articulos.uso = '3' "
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Formato"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				
				this.object.articulo_promocion_articulo[this.GetRow()] = resultado.valores[1]		
				this.object.articulos_descripcion[this.GetRow()] = resultado.valores[2]	
				this.object.articulo_promocion_cantidad[this.GetRow()] = 0
				this.object.formatos_abreviado[this.GetRow()] = resultado.valores[3]	
			end if
	END CHOOSE
end if	
	
end event

event clicked;call super::clicked;if not(cb_insertar.enabled)  then
	dw_pagina1.triggerevent(clicked!)
end if
end event

type pb_4 from picturebutton within pagina_1
boolean visible = false
integer x = 3790
integer y = 2504
integer width = 146
integer height = 128
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
end type

event clicked;
long fila_actual
string articulo_actual

if not(cb_insertar.enabled)  then
	dw_pag1.triggerevent(clicked!)
end if

articulo_actual = sle_valor.text

if isnull(articulo_actual) or articulo_actual = "" then
	MessageBox("Error","Debe seleccionar un articulos para poder insertar una nueva materia prima")
	return
end if

fila_actual = apartados.pagina_1.dw_promocion.InsertRow(0)

if fila_actual > 0 then
	apartados.pagina_1.dw_promocion.object.articulo_promocion_empresa[fila_actual] = codigo_empresa
	apartados.pagina_1.dw_promocion.object.articulo_promocion_articulo_promocion[fila_actual] = articulo_actual
end if

apartados.pagina_1.dw_promocion.accepttext()

end event

type pb_5 from picturebutton within pagina_1
boolean visible = false
integer x = 3954
integer y = 2504
integer width = 146
integer height = 128
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
end type

event clicked;
Boolean error_borrando
Long fila_actual


if not(cb_insertar.enabled)  then
	dw_pag1.triggerevent(clicked!)
end if

if apartados.pagina_1.dw_promocion.rowcount() <= 0 then
	return
end if

fila_actual = apartados.pagina_1.dw_promocion.getrow()
if apartados.pagina_1.dw_promocion.DeleteRow(fila_actual) <> 1 then
	error_borrando = True
else
	error_borrando = False
end if


if error_borrando then
	MessageBox("Error","No ha sido posible borrar la etiqueta")
end if



end event

type st_13 from statictext within pagina_2
integer x = 27
integer y = 12
integer width = 402
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_14 from statictext within pagina_2
integer x = 439
integer y = 12
integer width = 1865
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean border = true
boolean focusrectangle = false
end type

type dw_tarifas from datawindow within pagina_2
integer x = 2153
integer y = 160
integer width = 1207
integer height = 672
integer taborder = 11
string dataobject = "dw_tarifas_conjunto"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_3 from commandbutton within pagina_2
integer x = 2473
integer y = 1356
integer width = 690
integer height = 148
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Valoración de Stock"
end type

event clicked;
string v_fecha_tar_activa, v_fecha_alta
string v_calidad, v_formato, v_g2, v_g3, v_familia, v_modelo, v_activo, v_listar, v_usuario
string des_articulo, articulo_calidad, v_articulo, v_uso
dec{2} v_precio, v_ancho, v_largo, v_precio_base_c_r, v_valor_base_c_r, v_precio_base_l
dec{2} v_valor_base_l, v_precio_bizcocho, v_valor_bizcocho, v_valor_acabado, v_precio_acabado
dec  fila_actual
dec total_reg

select uso 
into :v_uso
from articulos 
where codigo = :sle_valor.text
and empresa = :codigo_empresa;

if v_uso = '2' then
	messagebox(" Aviso","Los artículos Intermedios los valorará el dpto. comercial", StopSign!)
	return
end if


select count(*) 
into   :total_reg
from venlintarifas
where articulo = :sle_valor.text
and 	tarifa = "5"
and empresa = :codigo_empresa;

select activa 
into :v_fecha_tar_activa
from ventarifas
where codigo = "5"
and empresa = :codigo_empresa;

v_calidad = "1"

fila_actual = apartados.pagina_1.dw_pagina1.Getrow()
v_formato = apartados.pagina_1.dw_pagina1.object.formato[fila_actual] 
v_familia = apartados.pagina_2.dw_pagina2.object.familia[fila_actual] 
v_usuario = apartados.pagina_1.dw_pagina1.object.usuario[fila_actual] 

select ancho, largo
into :v_ancho, :v_largo
from formatos
where empresa = :codigo_empresa
and   codigo = :v_formato;


// Extraemos parametros del código estadístico
fila_actual = apartados.pagina_2.dw_codestadistico.Getrow()
v_g2 = apartados.pagina_2.dw_codestadistico.object.G2[fila_actual]  
v_g3 = apartados.pagina_2.dw_codestadistico.object.G3[fila_actual] 

select precio_base_c_r, valor_base_c_r, precio_base_l, valor_base_l, precio_bizcocho, valor_bizcocho, valor_acabado
into :v_precio_base_c_r, :v_valor_base_c_r, :v_precio_base_l, :v_valor_base_l, :v_precio_bizcocho, 
     :v_valor_bizcocho, :v_valor_acabado
from valoracionbases
where empresa = :codigo_empresa
and codigo = "1";

if (v_g2 = "B") and ((v_g3 = "C") or (v_g3 = "R")) then
	v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_c_r * (1 - v_valor_base_c_r/100))
elseif (v_g2 = "B") and ((v_g3 = "L") or (v_g3 = "P"))then
	v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_l * (1 - v_valor_base_l/100))
elseif (v_g2 = "Z") then
	v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_bizcocho * (1 - v_valor_bizcocho/100))
else
	select precio 
	into   :v_precio_acabado
	from venlintarifas
	where articulo = :sle_valor.text
	and tarifa <> "5";
	v_precio = v_precio_acabado * (1 - v_valor_acabado/100)
end if

select codigo,descripcion
into :v_articulo,:des_articulo
from articulos
where empresa = :codigo_empresa
and codigo = :sle_valor.text;


v_fecha_alta = String(Today(), "dd/mm/yy hh:mm:ss")

articulo_calidad = v_articulo + right("00"+v_calidad,2) 

if total_reg = 0 then
	insert into venlintarifas
	(empresa, tarifa, fecha, articulo, calidad, precio, falta, montajeartcal, familia, formato, 
	activo, listar, usuario, descripcion, excepcion, tipo_linea)
	values (:codigo_empresa, "5", :v_fecha_tar_activa, :sle_valor.text, :v_calidad, :v_precio, :v_fecha_alta,
				:articulo_calidad, :v_familia, :v_formato, "S", "S", :v_usuario, :des_articulo, "N", "2");
else
	if MessageBox("Atención", "La tarifa valorada ya existe. ¿Desea actualizarla?.", Question!, YesNo!, 2) = 1 then
		update venlintarifas
		set fecha = :v_fecha_tar_activa, precio = :v_precio
		where empresa = :codigo_empresa
		and articulo = :sle_valor.text
		and tarifa  = "5";
	end if
end if

apartados.pagina_2.dw_tarifas.Retrieve(codigo_empresa, sle_valor.text)

end event

type r_4 from rectangle within pagina_2
integer linethickness = 4
long fillcolor = 8421504
integer x = 2459
integer y = 1348
integer width = 713
integer height = 168
end type

type dw_codestadistico from datawindow within pagina_2
integer y = 1268
integer width = 2354
integer height = 360
integer taborder = 21
boolean bringtotop = true
string dataobject = "dw_art_codestadistico"
boolean livescroll = true
end type

event clicked;if not(cb_insertar.enabled)  then
	dw_pagina2.triggerevent(clicked!)
end if
end event

event itemchanged;//DataWindowChild ldw_Hijo

//Recojo el identificados del DDDW (Handle) Utilizamos siempre "Descripcon_abr"
//poque todas las tablas que aquí se utilizan tienen los mismos nombres de campos
//apartados.pagina_5.dw_codestadistico.GetChild("art_grupo1_Descripcion_abr",ldw_Hijo)
//ldw_Hijo.SettransObject(SQLCA)
//
//if row > 0 then
//	if not Isnull(codigo_empresa) and Len(codigo_empresa) > 0 then
//		ldw_Hijo.Retrieve(codigo_empresa)
//	end if
//end if




end event

type st_11 from statictext within pagina_3
integer x = 27
integer y = 12
integer width = 402
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_12 from statictext within pagina_3
integer x = 439
integer y = 12
integer width = 1865
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean border = true
boolean focusrectangle = false
end type

type gb_3 from groupbox within pagina_3
integer x = 2958
integer y = 124
integer width = 398
integer height = 204
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_insertar_idiomas from commandbutton within pagina_3
integer x = 2967
integer y = 160
integer width = 375
integer height = 80
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Insertar"
end type

event clicked;long donde

donde = dw_pagina3.insertrow(0)
dw_pagina3.setitem(donde,"empresa",codigo_empresa)
dw_pagina3.setitem(donde,"articulo",sle_valor.text)
dw_pagina3.setfocus()
dw_pagina3.setrow(donde)
dw_pagina3.setcolumn("cliente")
nuevo_idioma = "S"


end event

type cb_borrar_idiomas from commandbutton within pagina_3
integer x = 2967
integer y = 240
integer width = 375
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Borrar"
end type

event clicked;dw_pagina3.deleterow(dw_pagina3.getrow())
end event

type st_17 from statictext within pagina_5
integer x = 32
integer y = 16
integer width = 389
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_16 from statictext within pagina_5
integer x = 434
integer y = 16
integer width = 1865
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean border = true
boolean focusrectangle = false
end type

type dw_listado_ficha from datawindow within pagina_5
boolean visible = false
integer x = 2912
integer y = 896
integer width = 311
integer height = 180
integer taborder = 11
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type r_3 from rectangle within pagina_5
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 8421504
integer x = 1691
integer y = 2344
integer width = 800
integer height = 192
end type

type rr_1 from roundrectangle within pagina_5
integer linethickness = 4
long fillcolor = 8421504
integer x = 1376
integer y = 2064
integer width = 814
integer height = 204
integer cornerheight = 40
integer cornerwidth = 46
end type

type cb_1 from commandbutton within pagina_5
integer x = 1216
integer y = 1684
integer width = 681
integer height = 96
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ficha Técnica"
end type

event clicked;if sle_valor.text <> "" then
	if not isnull(sle_valor.text) then
		str_parametros lstr_param
		lstr_param.s_argumentos[2] = sle_valor.text
		lstr_param.i_nargumentos = 2
//		OpenWithParm(w_mant_versiones_tencer, lstr_param)
		OpenWithParm(w_mant_altas_intermedios_nuevo, lstr_param)
	end if
end if
end event

type r_5 from rectangle within pagina_5
integer linethickness = 4
long fillcolor = 8421504
integer x = 2199
integer y = 8796
integer width = 942
integer height = 204
end type

type pb_1 from upb_imprimir within pagina_5
integer x = 1911
integer y = 1684
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type

event clicked;string escandallo[],version_esc[],camino
long   indice,total,i
tipo_array val,ent


dw_listado_ficha.reset()
if trim(sle_valor.text) <> "" then
	ent.valor[1] = "1"
	ent.valor[2] = "1"
	openWithParm(w_pedir_version,ent)
	val =  message.powerObjectparm
	IF val.valor[1] = "RETURN" Then Return
		f_imprimir_ficha_tecnica_ot(dw_listado_ficha, sle_valor.text, val.valor[1], val.valor[2], 0)
		f_imprimir_datawindow(dw_listado_ficha)
end if

end event

type r_6 from rectangle within pagina_5
integer linethickness = 4
long fillcolor = 8421504
integer x = 1179
integer y = 1660
integer width = 878
integer height = 140
end type

type cb_traspaso from commandbutton within pagina_5
boolean visible = false
integer x = 2245
integer y = 1456
integer width = 672
integer height = 96
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Traspaso bases"
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											RELLENAR EL CAMPO USO
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
datastore datos
boolean bien = true
string sel, v_articulo, v_g2
long i

if nombre_usuario <> "TENCER" and nombre_usuario <> "PTENCER" Then
	messagebox ("OJO", nombre_usuario+"!!!!,  este botón no se toca. ")
	return
else
	sel = " select articulos.codigo, art_codestadistico.g2 "+&
			" from articulos, art_codestadistico "+&
			" where articulos.empresa = '"+codigo_empresa+"'" +&
			" and art_codestadistico.empresa = '"+codigo_empresa+"'" +&
			" and articulos.codigo = art_codestadistico.codigo "

	f_cargar_cursor_nuevo(sel, datos)
	
	connect using SQLCA;
	i = 1

	do while (i <= datos.rowcount()) and bien
		v_articulo	 				= datos.object.articulos_codigo[i]
		v_g2							= datos.object.art_codestadistico_g2[i]
		
		if (datos.object.art_codestadistico_g2[i] = 'B') or (datos.object.art_codestadistico_g2[i]= 'N') or  (datos.object.art_codestadistico_g2[i] = 'Z') then
			update articulos
			set uso = '1'
			where codigo = :v_Articulo
			and empresa = :codigo_empresa;
		else
			update articulos
			set uso = '3'
			where codigo = :v_Articulo
			and empresa = :codigo_empresa;
		end if

		if SQLCA.SQLCode = -1 then
			bien = false
			messagebox("Error", "No se pudo traspasar el artículo :"+v_articulo)
		end if			
		
		f_mensaje_proceso("Rellenando el campo USO ", i, datos.rowcount() )
		i++
	loop
	if bien then 	
		commit using SQLCA;
	else
		rollback using SQLCA;
	end if	
end if

destroy datos


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
//										TRASPASO BASES 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
datastore datos
string sel, v_articulo, v_version, v_base, v_base2, v_aprovechar_base
long i
boolean bien = true
dec {2} v_factor_base

if nombre_usuario <> "TENCER" and nombre_usuario <> "PTENCER" Then
	messagebox ("OJO", nombre_usuario+"!!!!,  este botón no se toca. ")
	return
else
	sel = " select articulo, version, base, base2, factor_base, aprovechar_base "+&
			" from art_versiones "+&
			" where empresa = '"+codigo_empresa+"'"
			
	f_cargar_cursor_nuevo(sel, datos)
	
	connect using SQLCA;
	i = 1
	
	delete 
	from art_Escandallo 
	where empresa = :codigo_empresa;
	
	do while (i <= datos.rowcount()) and bien = true
		v_articulo	 				= datos.object.articulo[i]
		v_version 					= datos.object.version[i]
		v_base 						= datos.object.base[i]
		v_base2					= datos.object.base2[i]
		v_factor_base			= datos.object.factor_base[i]
		v_aprovechar_base		= datos.object.aprovechar_base[i]
		
		if not (isnull(v_base )) and (v_base <> "") then
			insert into art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
			values (:codigo_empresa, :v_articulo, :v_version, :v_base, :v_factor_base, :v_aprovechar_base);
			if SQLCA.SQLCode = -1 then
				bien = false
				messagebox("Error", "No se pudo traspasar el artículo :"+v_articulo)
			end if			
		else
			insert into art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
			values (:codigo_empresa, :v_articulo, :v_version, '0', :v_factor_base, :v_aprovechar_base);
			if SQLCA.SQLCode = -1 then
				bien = false
				messagebox("Error", "No se pudo traspasar el artículo :"+v_articulo)
			end if			
		end if
		
		if not (isnull (v_base2 )) and (v_base2 <> "") then
			insert into art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
			values (:codigo_empresa, :v_articulo, :v_version, : v_base2, :v_factor_base, :v_aprovechar_base);
			if SQLCA.SQLCode = -1 then
				bien = false
				messagebox("Error", "No se pudo traspasar el artículo :"+v_articulo)
			end if
		end if
		f_mensaje_proceso("Traspasando datos", i, datos.rowcount() )
		i++
		setnull(v_articulo)
		setnull(v_version)
		setnull(v_base)	
		setnull(v_base2)					
		setnull(v_factor_base)
		setnull(v_aprovechar_base	)
		
	loop
	if bien then 	
		commit;
	else
		rollback;
	end if	
end if

destroy datos
*/



end event

type cb_copiar_parametros from commandbutton within pagina_5
integer x = 1193
integer y = 1876
integer width = 869
integer height = 112
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Parámetros Base"
end type

event clicked;String molde, plato_sup, plato_inf, costilla, familia, relieve, cliente, descripcion, formato
str_aux_parametros_base parametros

if isnull(sle_valor.text) or trim(sle_valor.text) = "" then
	return
end if

SELECT molde, plato_sup, plato_inf, costilla, familia, relieve, cliente, descripcion, espesor, pesopieza, marco
INTO :parametros.molde, :parametros.plato_sup, :parametros.plato_inf, :parametros.costilla, :parametros.familia, :parametros.relieve, 
		:parametros.cliente, :parametros.descripcion, :parametros.espesor, :parametros.pesopieza, :parametros.marco
FROM articulos 
WHERE empresa = :codigo_empresa AND codigo = :sle_valor.text;

if fr_cambio_parametros_base(parametros, sle_valor.text) = 1 then
	Messagebox("Operación completada con éxito", "Se han cambiado correctamente los parámetros para los artículos descendientes.")
else
	Messagebox("Error", "No se han podido realizar los cambios.")
end if

end event

type pb_anyade_grupo from picturebutton within pagina_5
integer x = 343
integer y = 1628
integer width = 146
integer height = 128
integer taborder = 41
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;

long fila_actual
string articulo_actual

if not(cb_insertar.enabled)  then
	dw_pagina5.triggerevent(clicked!)
end if

articulo_actual = sle_valor.text

if isnull(articulo_actual) or articulo_actual = "" then
	MessageBox("Error","Debe seleccionar un articulo para poder insertar una nueva etiqueta")
	return
end if


fila_actual = apartados.pagina_5.dw_grupo_combi.InsertRow(0)

if fila_actual > 0 then
	
	apartados.pagina_5.dw_grupo_combi.object.articulos_grupo_combi_empresa[fila_actual] = codigo_empresa
	apartados.pagina_5.dw_grupo_combi.object.articulos_grupo_combi_articulo[fila_actual] = articulo_actual
	
end if

apartados.pagina_5.dw_grupo_combi.accepttext()







end event

type pb_borra_grupo from picturebutton within pagina_5
integer x = 494
integer y = 1628
integer width = 146
integer height = 128
integer taborder = 51
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;Boolean error_borrando
Long fila_actual


if not(cb_insertar.enabled)  then
	dw_pagina5.triggerevent(clicked!)
end if

if apartados.pagina_5.dw_grupo_combi.rowcount() <= 0 then
	return
end if

fila_actual = apartados.pagina_5.dw_grupo_combi.getRow()

if apartados.pagina_5.dw_grupo_combi.DeleteRow(fila_actual) <> 1 then
	error_borrando = True
else
	error_borrando = False
end if


if error_borrando then
	MessageBox("Error","No ha sido posible borrar la etiqueta")
end if


end event

type dw_grupo_combi from datawindow within pagina_5
event usr_dwnkey ( keycode key,  unsignedlong keyflags )
integer x = 325
integer y = 904
integer width = 1851
integer height = 720
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_articulos_grupo_combi"
boolean vscrollbar = true
boolean livescroll = true
end type

event usr_dwnkey(keycode key, unsignedlong keyflags);string campo
String modelo, cliente, propuesta, pieza,  version_color
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

//control_teclas (keyflags, key)

//messagebox("", string(key))


if key =  keyEnter! then
	
	campo = This.GetColumnName()
	//messagebox("", campo)
	CHOOSE CASE campo
		CASE "articulos_grupo_combi_grupo_combi"
			busqueda.titulo_ventana = "Búsqueda de grupos combinados"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION "+&
										" FROM grupo_combi "+&
										" where empresa = '"+codigo_empresa+"'"+&
										" ORDER BY descripcion"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Operacion"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.articulos_grupo_combi_grupo_combi[this.GetRow()]				=  integer(resultado.valores[1]	)	
				this.object.grupo_combi_descripcion[this.GetRow()]	= resultado.valores[2]		
			end if
			
			
	END CHOOSE
end if	
end event

event doubleclicked;this.EVENT usr_dwnkey(KeyEnter!, 0)
end event

event clicked;str_parametros lstr_param

if not(cb_insertar.enabled)  then
	dw_pagina5.triggerevent(clicked!)
end if


lstr_param.i_nargumentos    = 2
//lstr_param.s_argumentos[1]  = "wi_mant_articulos_conjunto_nuevo"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_grupo_combi'
 
   OpenWithParm(wtc_mant_grupo_combi,lstr_param)  


END CHOOSE


end event

event itemchanged;string resultado, resultado1, resultado2, resultado3, resultado4, resultado5
dec {2} ancho, largo
Decimal {6} gram_7x20, gramaje
String modelo, cliente, propuesta, pieza, version_color, busqueda
String Formato

this.Accepttext()

choose case dwo.name
	CASE "articulos_grupo_combi_grupo_combi"
		
		select descripcion
		into :resultado
		from grupo_combi
		where empresa = :codigo_empresa
		and codigo = :data;		
		
		if SQLCA.sqlcode <> 100 then
			this.object.grupo_combi_descripcion[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.grupo_combi_descripcion[Row] 	= ''
			return 2			
		end if
		
end choose
end event

event rbuttondown;this.EVENT usr_dwnkey(KeyEnter!, 0)
end event

type p_imagen from picture within pagina_7
integer x = 78
integer y = 224
integer width = 3186
integer height = 1868
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_imagen from u_dw_imagen within pagina_7
integer x = 82
integer y = 216
integer width = 3209
integer height = 1888
integer taborder = 130
end type

type pb_archivos_modelo from picturebutton within pagina_7
integer x = 91
integer y = 52
integer width = 146
integer height = 128
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\index.png"
alignment htextalign = left!
string powertiptext = "Archivos del Modelo"
end type

event clicked;str_parametros lstr_param
long esta_abierta

//La ventana será response
if not isnull(sle_valor.Text) and sle_valor.Text <> "" then
	lstr_param.s_argumentos[1] = sle_valor.Text
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_mant_articulos_imagen_encajado"
	lstr_param.resultado = ''
	Openwithparm(wtc_mant_articulos_imagen_encajado, lstr_param)
end if

end event

type st_7 from statictext within pagina_7
integer x = 283
integer y = 80
integer width = 590
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Imágenes Artículos"
boolean focusrectangle = false
end type

type dw_3 from datawindow within pagina_8
integer x = 343
integer y = 936
integer width = 2437
integer height = 656
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_articulos_calibre"
boolean border = false
boolean livescroll = true
end type

event itemchanged;decimal row1, datos, ancho_max, ancho_min, largo_max, largo_min, tolerancia_ancho, tolerancia_largo

IF dwo.name = "ancho_central" THEN
	datos = dec(data)
	
	row1 = dw_2.GetSelectedRow(0)
	
	tolerancia_ancho = dw_2.Object.tolerancia_ancho[row1]
	
	dw_3.Object.ancho_max[row] = datos + tolerancia_ancho
	dw_3.Object.ancho_min[row] = datos - tolerancia_ancho	
ELSE
	datos = dec(data)
	
	row1 = dw_2.GetSelectedRow(0)
	
	tolerancia_largo = dw_2.Object.tolerancia_largo[row1]
	
	dw_3.Object.largo_max[row] = datos + tolerancia_largo
	dw_3.Object.largo_min[row] = datos - tolerancia_largo
END IF

end event

type dw_2 from datawindow within pagina_8
integer x = 343
integer y = 72
integer width = 2437
integer height = 824
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_articulos_pastas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;decimal datos, ancho, largo, row1

IF dwo.name = "ancho" THEN
	datos = dec(data)
	largo = apartados.pagina_8.dw_2.Object.largo[row]
	apartados.pagina_8.dw_2.Object.area[row] = datos * largo
ELSEIF dwo.name = "largo" THEN
	datos = dec(data)
	ancho = apartados.pagina_8.dw_2.Object.ancho[row]
	apartados.pagina_8.dw_2.Object.area[row] = ancho * datos
ELSE
	
END IF


end event

event clicked;string empresa, codigo_articulo, pasta
int newrow3, contador
long total3;

dw_2.accepttext();
dw_3.accepttext();

apartados.TriggerEvent("pulsar_datawindow")

IF dwo.name = "codigo_articulo" THEN

	empresa = dw_2.Object.empresa[row];
	codigo_articulo = dw_2.Object.codigo_articulo[row];
	pasta = dw_2.Object.pasta[row];
	
	This.SelectRow(0, false)
	This.SelectRow(row, true)
	
	total3 = dw_3.retrieve(empresa, codigo_articulo, pasta);
	contador = dw_3.RowCount();
	
	IF contador = 0 THEN
		newrow3 = dw_3.insertRow(0);
		dw_3.Object.pasta[newrow3] = pasta
		dw_3.Object.calibre[newrow3] = "4"
		dw_3.Object.ancho_central[newrow3] = 00
		dw_3.Object.largo_central[newrow3] = 00
	
		newrow3 = dw_3.insertRow(0);
		dw_3.Object.pasta[newrow3] = pasta
		dw_3.Object.calibre[newrow3] = "5"
		dw_3.Object.ancho_central[newrow3] = 00
		dw_3.Object.largo_central[newrow3] = 00
	
		newrow3 = dw_3.insertRow(0);
		dw_3.Object.pasta[newrow3] = pasta
		dw_3.Object.calibre[newrow3] = "6"
		dw_3.Object.ancho_central[newrow3] = 00
		dw_3.Object.largo_central[newrow3] = 00	
	END IF
END IF
end event

type pb_añadir from picturebutton within pagina_8
integer x = 379
integer y = 740
integer width = 146
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer\Add_24x24.png"
alignment htextalign = left!
end type

event clicked;string empresa, codigo_articulo, descripcion
int newrow2, rtn
long total2;

apartados.TriggerEvent("pulsar_datawindow")

Boolean resultado
resultado = false

dw_2.accepttext();

empresa = apartados.pagina_1.dw_pagina1.Object.empresa[1]
codigo_articulo = apartados.pagina_1.dw_pagina1.Object.codigo[1]

IF isnull(codigo_articulo) OR codigo_articulo = "" THEN
	messagebox("Error: ", "No se encuentra el codigo")
ELSE
	descripcion = apartados.pagina_1.dw_pagina1.Object.articulos_descripcion[1]
	
	newrow2 = dw_2.insertRow(0);
	dw_2.Object.codigo_articulo[newrow2] = codigo_articulo
	dw_2.Object.empresa[newrow2] = empresa
	dw_2.Object.descripcion[newrow2] = descripcion
	dw_2.Object.pasta[newrow2] 
	dw_2.Object.ancho[newrow2] = 00
	dw_2.Object.largo[newrow2] = 00
	dw_2.Object.tolerancia_ancho[newrow2] = 00
	dw_2.Object.tolerancia_largo[newrow2] = 00
END IF
end event

type pb_borrar from picturebutton within pagina_8
integer x = 539
integer y = 740
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer\Delete_24x24.png"
alignment htextalign = left!
end type

event clicked;int i, contador, rtn, row1, borrar
string codigo_articulo, pasta, botones[2], empresa
str_ventana_alerta parametros

rtn = 1 //Todo ok

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar registro"
parametros.mensaje = "¿Desea borrar el registro?"
parametros.tipo = 1
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

IF borrar = 1 THEN
	row1 = dw_2.GetSelectedRow(0)
	codigo_articulo = dw_2.Object.codigo_articulo[row1]
	pasta = dw_2.Object.pasta[row1]
	
	rtn = dw_2.deleterow(row1)
	
	rtn = dw_2.Update()

	IF rtn = 1 THEN
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;
	END IF
	
	contador = dw_3.RowCount()
	for i = 1 to contador
		if rtn  <> -1 then
			rtn = dw_3.deleterow(1)
		end if
	next
	
	rtn = dw_3.Update()
	
	IF rtn = 1 THEN
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;
	END IF
END IF


/*
row1 = dw_2.GetSelectedRow(0)
codigo_articulo = dw_2.Object.codigo_articulo[row1]
pasta = dw_2.Object.pasta[row1]

DELETE FROM articulos_pastas
WHERE codigo_articulo = :codigo_articulo AND
		   pasta = :pasta USING sqlca;

if sqlca.sqlcode <> 0 THEN
	MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
	ROLLBACK USING sqlca;
else
	COMMIT USING sqlca;
END IF

DELETE FROM articulos_calibres
WHERE codigo_articulo = :codigo_articulo AND
		   pasta = :pasta USING sqlca;

if sqlca.sqlcode <> 0 THEN
	MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
	ROLLBACK USING sqlca;
else
	COMMIT USING sqlca;
END IF

rtn = dw_2.deleterow(row1)
dw_3.reset()
*/
end event

type pb_calculadora2 from picturebutton within w_mant_articulos_tencer
integer x = 882
integer y = 156
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Compute!"
string disabledname = "c:\bmp\calculadisabled.bmp"
alignment htextalign = left!
end type

event clicked;/*
long iteraciones, v_codigo
boolean exito
string v_tabla, v_titulo, v_empresa_mas_tabla 
datetime v_fecha

v_tabla = "articulos"
v_titulo = v_tabla
v_fecha = datetime (today())

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla

connect using sqlca;

delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_tabla
and titulo = "articulos";

if sqlca.sqlcode= 0 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
end if
// Fin de borrar bloqueos del usuario actual

select max (convert(integer, codigo))
into :v_codigo
from articulos 
where empresa = :codigo_empresa;

v_codigo ++


DO WHILE iteraciones < 10 and not exito
	INSERT INTO uti_bloqueo (tabla, codigo, titulo, fecha, usuario)
					VALUES (:v_empresa_mas_tabla, :v_codigo, :v_titulo, :v_fecha, :nombre_usuario);
	if sqlca.sqlcode= 0 then 
		commit;
		exito = true
	else
		rollback;
		iteraciones ++
		v_codigo ++
	end if
LOOP

if iteraciones >= 10 then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=string(v_codigo)
	apartados.TriggerEvent("pulsar_datawindow")
end if
*/

Long codigo
codigo = f_colisiones2(codigo_empresa, "articulos", "codigo", "",false)

if codigo = 0  then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=String(codigo)
	apartados.TriggerEvent("pulsar_datawindow")
end if


end event

type cb_generar from commandbutton within w_mant_articulos_tencer
boolean visible = false
integer x = 4379
integer y = 452
integer width = 1038
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar artículos abrir base"
end type

event clicked;if nombre_usuario = 'TENCER' OR nombre_usuario = 'PTENCER' then

	datastore datos
	string sel, base, nuevo_articulo
	long i,j, k
	
	sel = " select articulos.codigo "+&
			" from articulos, art_codestadistico "+&
			" where articulos.empresa = art_codestadistico.empresa "+&
			" and articulos.codigo = art_codestadistico.codigo "+&
			" and articulos.uso = '1' "+&
			" and articulos.empresa = '"+codigo_empresa+"' "+&
			" and art_codestadistico.G2 = 'N' "

	//		" and articulos.codigo = '274' "+&
	
	f_cargar_cursor_nuevo ( sel, datos )
	 
	
	for i = 1 to datos.rowcount()
	
		base = datos.object.articulos_codigo[i]
		nuevo_articulo = f_duplicar_articulo(codigo_empresa, base)
		
		update art_escandallo
		set articulo_ant = :nuevo_articulo
		where articulo_ant = :base
		and empresa = :codigo_empresa;
		
	
		insert art_escandallo 
				( empresa, articulo, articulo_ant, factor, version )
		values (:codigo_empresa, :nuevo_articulo, :base, '1', '1' );
		
		commit using SQLCA;
	
		f_mensaje_proceso ("Regs: ", i, datos.rowcount())	
	next
			 
			 
	destroy datos
else
	messagebox("Ehhh", "No toques este botón")
	
end if
end event

type cb_2 from commandbutton within w_mant_articulos_tencer
boolean visible = false
integer x = 5408
integer y = 256
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;string v_empresa, v_articulo

//DECLARE estructura_articulo procedure for sp_estructura_articulo
//	('1', padre = '450');
//
//EXECUTE estructura_articulo;
//
//FETCH estructura_articulo INTO :v_empresa, :v_articulo ;
//
//v_empresa = v_empresa

/*
datastore datos
string sel
long i
string articulo, etiqueta, codigo_sin_dc, codigo_con_dc, prefijo, codigo_articulo, i_string

sel = " select empresa, codigo "+&
		" from articulos "+&
		" where uso = '3'  "+&
		" and promocion = 'N' "+&
		" and fecha_anulado is null  "+&
		" and familia = '2' "

f_cargar_cursor_nuevo (sel, datos)

prefijo = '8434768'
for i = 1 to datos.rowcount()
	articulo = datos.object.codigo[i]
	i_string = string (i)
	if len(i_string) = 1 then codigo_articulo =  '0000'+i_string
	if len(i_string) = 2 then codigo_articulo =  '000'+i_string
	if len(i_string) = 3 then codigo_articulo =  '00'+i_string
	if len(i_string) = 4 then codigo_articulo =  '0'+i_string



	codigo_sin_dc = prefijo + codigo_articulo
	codigo_con_dc = f_calcula_ean13 (codigo_sin_dc)

	update articulos set ean13 = :codigo_con_dc
	where articulos.empresa = :codigo_empresa and articulos.codigo = :articulo using sqlca;
//	insert into articulos_etiqueta (empresa, articulo, etiqueta) values (:codigo_empresa, :articulo, '1') using sqlca;
	commit using sqlca;
next

destroy datos
*/

datastore datos
string sel
long i
string articulo



sel = " 	WITH TreeView AS ( "+&
" 	SELECT	dbo.articulos.empresa, "+&
" 			articulo,  "+&
" 			uso, "+&
" 			factor,  "+&
" 			articulo_ant,  "+&
" 			1 AS nivel,  "+&
" 			CONVERT(float, 1) AS fac_acumulado,  "+&
" 			ISNULL(articulo, '') AS raiz "+&
" 	FROM    dbo.art_escandallo "+&
" 	inner join dbo.articulos on dbo.art_escandallo.articulo = dbo.articulos.codigo and dbo.art_escandallo.empresa = dbo.articulos.empresa "+&
" 	UNION ALL "+&
" 	SELECT	n.empresa, "+&
" 			n.articulo,  "+&
" 			ART.uso, "+&
" 			n.factor,  "+&
" 			n.articulo_ant,  "+&
" 			tv.nivel + 1 AS nivel,  "+&
" 			CONVERT(float, tv.fac_acumulado) / CONVERT(float, (CASE WHEN isnull(n.factor, 0) = 0 THEN 1 ELSE n.factor END)) AS fac_acumulado,  "+&
" 			tv.raiz AS raiz "+&
" 	FROM    dbo.art_escandallo AS n  "+&
" 	INNER JOIN TreeView AS tv ON n.articulo = tv.articulo_ant and n.empresa = tv.empresa "+&
" 	INNER JOIN articulos AS ART ON n.articulo = ART.codigo and n.empresa = ART.empresa) "+&
" 	SELECT  TOP (100) PERCENT TreeView_1.empresa, TreeView_1.articulo, TreeView_1.uso,  TreeView_1.factor, TreeView_1.articulo_ant,  "+&
" 			TreeView_1.nivel, TreeView_1.fac_acumulado, TreeView_1.raiz, O.coste_fab, O.coste_mp, O.coste_packing,  "+&
" 			O.coste_compras, O.coste_fab_mermas, O.coste_mp_mermas, O.empresa, O.version,  "+&
" 			ISNULL(O.coste_fab, 0) + ISNULL(O.coste_mp, 0) + ISNULL(O.coste_packing, 0) + ISNULL(O.coste_compras,0) + ISNULL(O.coste_fab_mermas, 0) + ISNULL(O.coste_mp_mermas, 0) AS coste_total  "+&
" 			, isnull( TreeView_2.fac_acumulado, 1) as factor_operar "+&
" 	FROM  TreeView AS TreeView_1  "+&
" 	INNER JOIN	dbo.art_ver_operaciones AS O ON TreeView_1.articulo = O.articulo and TreeView_1.empresa = O.empresa "+&
" 	left outer JOIN TreeView AS TreeView_2 on (TreeView_2.articulo_ant = TreeView_1.articulo ) AND (TreeView_2.raiz = TreeView_1.raiz) "+&
" 	where TreeView_1.raiz = '450' "+&
" 	and TreeView_1.empresa = '1' "+&
" 	and ( TreeView_1.nivel -1 = TreeView_2.nivel or TreeView_2.nivel is null) "+&
" 	order by TreeView_1.nivel desc  "

f_cargar_cursor_nuevo (sel, datos)
for i = 1 to datos.rowcount()
	articulo = datos.object.articulo[i]
next

destroy datos



   

end event

type r_1 from rectangle within w_mant_articulos_tencer
integer linethickness = 4
long fillcolor = 12639424
integer x = 4553
integer y = 140
integer width = 1257
integer height = 116
end type

type st_aviso from statictext within w_mant_articulos_tencer
integer x = 1056
integer y = 120
integer width = 3424
integer height = 160
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 134217857
long backcolor = 553648127
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_mant_articulos_tencer
integer x = 3291
integer y = 264
integer width = 622
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asignar EAN13 SGA"
end type

event clicked;datastore ds_datos
string ls_sel
long   ll_indice,ll_total
string ls_articulo

long   ll_nuevo_ean,ll_nuevo_ean_sga
string ls_familia,ls_prefijo_ean13,ls_prefijo_ean13_sga,ls_nuevo_ean,ls_ean13,ls_nuevo_ean_sga,ls_ean13_sga
int    li_longitud_ean,li_longitud_prefijo,li_longitud_sufijo

//update articulos set ean13_sga = "";
//commit;

ls_sel = "select articulos.codigo,articulos.familia,articulos.ean13,articulos.descripcion "+&
			"from articulos "+&
			"where articulos.empresa = '"+codigo_empresa+"' "+&
			"and articulos.uso in ('0','1','3') "+&
			"and articulos.promocion = 'N' "+&
			"and articulos.fecha_anulado is null "+&
			"and isnull(articulos.ean13_sga,'') = '' "+&
			"and articulos.codigo in(select almacenmovimientos.articulo from almacenmovimientos where almacenmovimientos.empresa = '"+codigo_empresa+"' ) "+&
			"order by convert(dec(15,0),articulos.codigo)"


ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	
	ls_articulo = ds_datos.object.codigo[ll_indice]
	ls_familia  = ds_datos.object.familia[ll_indice]
	ls_ean13    = ds_datos.object.ean13[ll_indice]
	
	SELECT ltrim(rtrim(isnull(familias.prefijo_ean13,''))), 
			 ltrim(rtrim(isnull(familias.prefijo_ean13_sga,''))) 
	INTO   :ls_prefijo_ean13,
			 :ls_prefijo_ean13_sga 
	FROM   familias 
	WHERE  familias.empresa = :codigo_empresa
	AND    familias.codigo  = :ls_familia;
		
	li_longitud_ean     = 12	
	
	if isnull(ls_ean13) then ls_ean13 = ""
		
	if trim(ls_prefijo_ean13_sga) <> "" then
		if ls_prefijo_ean13 = ls_prefijo_ean13_sga then
			ls_nuevo_ean_sga = ls_ean13
		else
			li_longitud_prefijo = len(ls_prefijo_ean13_sga)
			li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo			

			select isnull(max(convert(dec(12,0),substring(articulos.ean13_sga,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
			into   :ll_nuevo_ean_sga
			from   articulos
			where  articulos.empresa = :codigo_empresa
			and    isnull(articulos.ean13_sga,'') <> ''
			and    substring(articulos.ean13_sga,1,:li_longitud_prefijo) = :ls_prefijo_ean13_sga;	
										
			ls_nuevo_ean_sga = ls_prefijo_ean13_sga+string(ll_nuevo_ean_sga,left("000000000000",li_longitud_sufijo))
			ls_nuevo_ean_sga = f_calcula_ean13(ls_nuevo_ean_sga)
			
		end if
	end if		

	update articulos 
	set    ean13_sga = :ls_nuevo_ean_sga
	where  articulos.empresa = :codigo_empresa
	and    articulos.codigo  = :ls_articulo using sqlca;

	commit using sqlca;
next

destroy ds_datos

end event

type cb_5 from commandbutton within w_mant_articulos_tencer
integer x = 3913
integer y = 264
integer width = 768
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asignar EAN13 SGA Prom"
end type

event clicked;datastore ds_datos
string ls_sel
long   ll_indice,ll_total
string ls_articulo

long   ll_nuevo_ean,ll_nuevo_ean_sga
string ls_familia,ls_prefijo_ean13,ls_prefijo_ean13_sga,ls_nuevo_ean,ls_ean13,ls_nuevo_ean_sga,ls_ean13_sga
int    li_longitud_ean,li_longitud_prefijo,li_longitud_sufijo

//update articulos set ean13_sga = "";
//commit;

ls_sel = "select articulos.codigo,articulos.familia,articulos.ean13,articulos.descripcion "+&
			"from articulos "+&
			"where articulos.empresa = '"+codigo_empresa+"' "+&
			"and articulos.uso in ('1','3') "+&
			"and articulos.promocion = 'S' "+&
			"and articulos.fecha_anulado is null "+&
			"and isnull(articulos.ean13_sga,'') = '' "+&
			"and articulos.codigo in(select almacenmovimientos.articulo from almacenmovimientos where almacenmovimientos.empresa = '"+codigo_empresa+"' ) "+&
			"order by convert(dec(15,0),articulos.codigo)"


ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	
	ls_articulo = ds_datos.object.codigo[ll_indice]
	ls_familia  = ds_datos.object.familia[ll_indice]
	ls_ean13    = ds_datos.object.ean13[ll_indice]
	
	SELECT ltrim(rtrim(isnull(familias.prefijo_ean13,''))), 
			 ltrim(rtrim(isnull(familias.prefijo_ean13_sga,''))) 
	INTO   :ls_prefijo_ean13,
			 :ls_prefijo_ean13_sga 
	FROM   familias 
	WHERE  familias.empresa = :codigo_empresa
	AND    familias.codigo  = :ls_familia;
		
	ls_prefijo_ean13 = ""
	ls_prefijo_ean13_sga = "29"
		
	li_longitud_ean     = 12	
	
	if isnull(ls_ean13) then ls_ean13 = ""
		
	if trim(ls_prefijo_ean13_sga) <> "" then
		if ls_prefijo_ean13 = ls_prefijo_ean13_sga then
			ls_nuevo_ean_sga = ls_ean13
		else
			li_longitud_prefijo = len(ls_prefijo_ean13_sga)
			li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo			

			select isnull(max(convert(dec(12,0),substring(articulos.ean13_sga,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
			into   :ll_nuevo_ean_sga
			from   articulos
			where  articulos.empresa = :codigo_empresa
			and    isnull(articulos.ean13_sga,'') <> ''
			and    substring(articulos.ean13_sga,1,:li_longitud_prefijo) = :ls_prefijo_ean13_sga;	
										
			ls_nuevo_ean_sga = ls_prefijo_ean13_sga+string(ll_nuevo_ean_sga,left("000000000000",li_longitud_sufijo))
			ls_nuevo_ean_sga = f_calcula_ean13(ls_nuevo_ean_sga)
			
		end if
	end if		

	update articulos 
	set    ean13_sga = :ls_nuevo_ean_sga
	where  articulos.empresa = :codigo_empresa
	and    articulos.codigo  = :ls_articulo using sqlca;

	commit using sqlca;
next

destroy ds_datos

end event

type cb_6 from commandbutton within w_mant_articulos_tencer
integer x = 4681
integer y = 264
integer width = 777
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asignar EAN13 SGA Cajas"
end type

event clicked;datastore ds_datos
string ls_sel
long   ll_indice,ll_total
string ls_articulo

long   ll_nuevo_ean,ll_nuevo_ean_sga
string ls_familia,ls_prefijo_ean13,ls_prefijo_ean13_sga,ls_nuevo_ean,ls_ean13,ls_nuevo_ean_sga,ls_ean13_sga
int    li_longitud_ean,li_longitud_prefijo,li_longitud_sufijo

//update articulos set ean13_sga = "";
//commit;

ls_sel = "select articulos.codigo,articulos.familia,articulos.ean13,articulos.descripcion "+&
			"from articulos "+&
			"where articulos.empresa = '"+codigo_empresa+"' "+&
			"and articulos.uso in ('0') "+&
			"and articulos.promocion = 'S' "+&
			"and articulos.fecha_anulado is null "+&
			"and isnull(articulos.ean13_sga,'') = '' "+&
			"and articulos.codigo in(select almacenmovimientos.articulo from almacenmovimientos where almacenmovimientos.empresa = '"+codigo_empresa+"' ) "+&
			"order by convert(dec(15,0),articulos.codigo)"


ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

for ll_indice = 1 to ll_total
	f_mensaje_proceso("",ll_indice,ll_total)
	
	ls_articulo = ds_datos.object.codigo[ll_indice]
	ls_familia  = ds_datos.object.familia[ll_indice]
	ls_ean13    = ds_datos.object.ean13[ll_indice]
	
	SELECT ltrim(rtrim(isnull(familias.prefijo_ean13,''))), 
			 ltrim(rtrim(isnull(familias.prefijo_ean13_sga,''))) 
	INTO   :ls_prefijo_ean13,
			 :ls_prefijo_ean13_sga 
	FROM   familias 
	WHERE  familias.empresa = :codigo_empresa
	AND    familias.codigo  = :ls_familia;
		
	ls_prefijo_ean13 = ""
	ls_prefijo_ean13_sga = "29"
		
	li_longitud_ean     = 12	
	
	if isnull(ls_ean13) then ls_ean13 = ""
		
	if trim(ls_prefijo_ean13_sga) <> "" then
		if ls_prefijo_ean13 = ls_prefijo_ean13_sga then
			ls_nuevo_ean_sga = ls_ean13
		else
			li_longitud_prefijo = len(ls_prefijo_ean13_sga)
			li_longitud_sufijo  = li_longitud_ean - li_longitud_prefijo			

			select isnull(max(convert(dec(12,0),substring(articulos.ean13_sga,(:li_longitud_prefijo +1),:li_longitud_sufijo))),0) + 1
			into   :ll_nuevo_ean_sga
			from   articulos
			where  articulos.empresa = :codigo_empresa
			and    isnull(articulos.ean13_sga,'') <> ''
			and    substring(articulos.ean13_sga,1,:li_longitud_prefijo) = :ls_prefijo_ean13_sga;	
										
			ls_nuevo_ean_sga = ls_prefijo_ean13_sga+string(ll_nuevo_ean_sga,left("000000000000",li_longitud_sufijo))
			ls_nuevo_ean_sga = f_calcula_ean13(ls_nuevo_ean_sga)
			
		end if
	end if		

	update articulos 
	set    ean13_sga = :ls_nuevo_ean_sga
	where  articulos.empresa = :codigo_empresa
	and    articulos.codigo  = :ls_articulo using sqlca;

	commit using sqlca;
next

destroy ds_datos

end event

