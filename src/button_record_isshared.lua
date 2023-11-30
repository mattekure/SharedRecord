local _nodeSrc = nil;

function onInit()
    if super and super.onInit then
        super.onInit();
    end
    if not Session.IsHost then
        return;
    end

    _nodeSrc = window.getDatabaseNode();

    if _nodeSrc then
        self.onUpdate();
        DB.addHandler(_nodeSrc, "onObserverUpdate", self.onUpdate)
    else
        _nodeSrc = nil;
        setVisible(false)
    end
end

function onUpdate()
    if DB.isPublic(_nodeSrc) then
        setTooltipText("Record is shared with all players, click to Unshare")
        setIcons("record_public");
        setVisible(true);
    elseif self.isShared() then
        setTooltipText("Record is shared only with " .. self.genSharedList() .. ". Click to Unshare")
        setIcons("record_shared");
        setVisible(true);
    else
        setVisible(false);
    end
end

function isShared()
    local tHolders = DB.getHolders(_nodeSrc);
    if #tHolders > 0 then
        return true;
    else
        return false;
    end
end

function onClose()
    if Session.IsHost then
        DB.removeHandler(_nodeSrc, "onObserverUpdate", self.onUpdate)
    end
end

function genSharedList()
    local tHolders = DB.getHolders(_nodeSrc);
    local sList = nil;
    if #tHolders > 1 then
        for i, v in ipairs(tHolders) do
            if i == #tHolders then
                sList = sList .. tHolders[i];
            else
                sList = sList .. tHolders[i] .. ", ";
            end
        end
    else
        sList = tHolders[1];
    end
    return sList;
end

function onButtonPress()
    self.unshareRecord();
    return true;
end

function unshareRecord()
    if not Session.IsHost then return; end

    if DB.isPublic(_nodeSrc) then
        DB.setPublic(_nodeSrc, false);
    else
        DB.removeAllHolders(_nodeSrc, true);
    end
end
